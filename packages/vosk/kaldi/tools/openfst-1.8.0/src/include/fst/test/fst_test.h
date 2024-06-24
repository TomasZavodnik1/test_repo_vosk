// Copyright 2005-2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the 'License');
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an 'AS IS' BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// See www.openfst.org for extensive documentation on this weighted
// finite-state transducer library.
//
// Regression test for FST classes.

#ifndef FST_TEST_FST_TEST_H_
#define FST_TEST_FST_TEST_H_

#include <fst/equal.h>
#include <fstream>
#include <fst/matcher.h>
#include <fst/vector-fst.h>
#include <fst/verify.h>

DECLARE_string(tmpdir);

namespace fst {

// This tests an Fst F that is assumed to have a copy method from an
// arbitrary Fst. Some test functions make further assumptions mostly
// obvious from their name. These tests are written as member temple
// functions that take a test fst as its argument so that different
// Fsts in the interface hierarchy can be tested separately and so
// that we can instantiate only those tests that make sense for a
// particular Fst.
template <class F>
class FstTester {
 public:
  using Arc = typename F::Arc;
  using StateId = typename Arc::StateId;
  using Weight = typename Arc::Weight;
  using Label = typename Arc::Label;

  explicit FstTester(size_t num_states = 128, bool weighted = true)
      : num_states_(num_states), weighted_(weighted) {
    VectorFst<Arc> vfst;
    InitFst(&vfst, num_states);
    testfst_ = new F(vfst);
  }

  ~FstTester() { delete testfst_; }

  // This verifies the contents described in InitFst() using
  // methods defined in a generic Fst.
  template <class G>
  void TestBase(const G &fst) const {
    StateId ns = 0;
    StateIterator<G> siter(fst);
    Matcher<G> matcher(fst, MATCH_INPUT);
    MatchType match_type = matcher.Type(true);
    bool has_states = false;
    for (; !siter.Done(); siter.Next()) {
      has_states = true;
    }
    CHECK_EQ(fst.Start(), has_states ? 0 : kNoStateId);
    for (siter.Reset(); !siter.Done(); siter.Next()) {
      StateId s = siter.Value();
      matcher.SetState(s);
      CHECK_EQ(fst.Final(s), NthWeight(s));
      size_t na = 0;
      ArcIterator<G> aiter(fst, s);
      for (; !aiter.Done(); aiter.Next()) {
      }
      for (aiter.Reset(); !aiter.Done(); aiter.Next()) {
        ++na;
        const Arc &arc = aiter.Value();
        CHECK_EQ(arc.ilabel, na);
        CHECK_EQ(arc.olabel, 0);
        CHECK_EQ(arc.weight, NthWeight(na));
        if (na == ns + 1) {
          CHECK_EQ(arc.nextstate, s == num_states_ - 1 ? 0 : s + 1);
        } else {
          CHECK_EQ(arc.nextstate, s);
        }
        if (match_type == MATCH_INPUT) {
          CHECK(matcher.Find(arc.ilabel));
          CHECK_EQ(matcher.Value().ilabel, arc.ilabel);
        }
      }
      CHECK_EQ(na, s + 1);
      CHECK_EQ(na, aiter.Position());
      CHECK_EQ(fst.NumArcs(s), s + 1);
      CHECK_EQ(fst.NumInputEpsilons(s), 0);
      CHECK_EQ(fst.NumOutputEpsilons(s), s + 1);
      CHECK(!matcher.Find(s + 2));     // out-of-range
      CHECK(!matcher.Find(kNoLabel));  // no explicit input epsilons
      CHECK(matcher.Find(0));
      CHECK_EQ(matcher.Value().ilabel, kNoLabel);  // implicit epsilon loop
      ++ns;
    }
    CHECK_EQ(num_states_, ns);
    CHECK(Verify(fst));
    CHECK(fst.Properties(ns > 0 ? kNotAcceptor : kAcceptor, true));
    CHECK(fst.Properties(ns > 0 ? kOEpsilons : kNoOEpsilons, true));
  }

  void TestBase() const { TestBase(*testfst_); }

  // This verifies methods specfic to an ExpandedFst.
  template <class G>
  void TestExpanded(const G &fst) const {
    CHECK_EQ(fst.NumStates(), num_states_);
    StateId ns = 0;
    for (StateIterator<G> siter(fst); !siter.Done(); siter.Next()) {
      ++ns;
    }
    CHECK_EQ(fst.NumStates(), ns);
    CHECK(fst.Properties(kExpanded, false));
  }

  void TestExpanded() const { TestExpanded(*testfst_); }

  // This verifies methods specific to a MutableFst.
  template <class G>
  void TestMutable(G *fst) const {
    for (StateIterator<G> siter(*fst); !siter.Done(); siter.Next()) {
      StateId s = siter.Value();
      size_t na = 0;
      size_t ni = fst->NumInputEpsilons(s);
      MutableArcIterator<G> aiter(fst, s);
      for (; !aiter.Done(); aiter.Next()) {
      }
      for (aiter.Reset(); !aiter.Done(); aiter.Next()) {
        ++na;
        Arc arc = aiter.Value();
        arc.ilabel = 0;
        aiter.SetValue(arc);
        arc = aiter.Value();
        CHECK_EQ(arc.ilabel, 0);
        CHECK_EQ(fst->NumInputEpsilons(s), ni + 1);
        arc.ilabel = na;
        aiter.SetValue(arc);
        CHECK_EQ(fst->NumInputEpsilons(s), ni);
      }
    }

    G *cfst1 = fst->Copy();
    cfst1->DeleteStates();
    CHECK_EQ(cfst1->NumStates(), 0);
    delete cfst1;

    G *cfst2 = fst->Copy();
    for (StateIterator<G> siter(*cfst2); !siter.Done(); siter.Next()) {
      StateId s = siter.Value();
      cfst2->DeleteArcs(s);
      CHECK_EQ(cfst2->NumArcs(s), 0);
      CHECK_EQ(cfst2->NumInputEpsilons(s), 0);
      CHECK_EQ(cfst2->NumOutputEpsilons(s), 0);
    }
    delete cfst2;
  }

  void TestMutable() { TestMutable(testfst_); }

  // This verifies operator=
  template <class G>
  void TestAssign(const G &fst) const {
    // Assignment from G
    G afst1;
    afst1 = fst;
    CHECK(Equal(fst, afst1));

    // Assignment from Fst
    G afst2;
    afst2 = static_cast<const Fst<Arc> &>(fst);
    CHECK(Equal(fst, afst2));

    // Assignment from self
    afst2.operator=(afst2);
    CHECK(Equal(fst, afst2));
  }

  void TestAssign() { TestAssign(*testfst_); }

  // This verifies the copy constructor and Copy method.
  template <class G>
  void TestCopy(const G &fst) const {
    // Copy from G
    G c1fst(fst);
    TestBase(c1fst);

    // Copy from Fst
    const G c2fst(static_cast<const Fst<Arc> &>(fst));
    TestBase(c2fst);

    // Copy from self
    const G *c3fst = fst.Copy();
    TestBase(*c3fst);
    delete c3fst;
  }

  void TestCopy() const { TestCopy(*testfst_); }

  // This verifies the read/write methods.
  template <class G>
  void TestIO(const G &fst) const {
    const std::string filename = FLAGS_tmpdir + "/test.fst";
    const std::string aligned = FLAGS_tmpdir + "/aligned.fst";
    {
      // write/read
      CHECK(fst.Write(filename));
      G *ffst = G::Read(filename);
      CHECK(ffst);
      TestBase(*ffst);
      delete ffst;
    }

    {
      // generic read/cast/test
      Fst<Arc> *gfst = Fst<Arc>::Read(filename);
      CHECK(gfst);
      G *dfst = fst::down_cast<G *>(gfst);
      TestBase(*dfst);

      // generic write/read/test
      CHECK(gfst->Write(filename));
      Fst<Arc> *hfst = Fst<Arc>::Read(filename);
      CHECK(hfst);
      TestBase(*hfst);
      delete gfst;
      delete hfst;
    }

    {
      // check mmaping by first writing the file with the aligned attribute set
      {
        std::ofstream ostr(aligned);
        FstWriteOptions opts;
        opts.source = aligned;
        opts.align = true;
        CHECK(fst.Write(ostr, opts));
      }
      std::ifstream istr(aligned);
      FstReadOptions opts;
      opts.mode = FstReadOptions::ReadMode("map");
      opts.source = aligned;
      G *gfst = G::Read(istr, opts);
      CHECK(gfst);
      TestBase(*gfst);
      delete gfst;
    }

    // check mmaping of unaligned files to make sure it does not fail.
    {
      {
        std::ofstream ostr(aligned);
        FstWriteOptions opts;
        opts.source = aligned;
        opts.align = false;
        CHECK(fst.Write(ostr, opts));
      }
      std::ifstream istr(aligned);
      FstReadOptions opts;
      opts.mode = FstReadOptions::ReadMode("map");
      opts.source = aligned;
      G *gfst = G::Read(istr, opts);
      CHECK(gfst);
      TestBase(*gfst);
      delete gfst;
    }

    // expanded write/read/test
    if (fst.Properties(kExpanded, false)) {
      ExpandedFst<Arc> *efst = ExpandedFst<Arc>::Read(filename);
      CHECK(efst);
      TestBase(*efst);
      TestExpanded(*efst);
      delete efst;
    }

    // mutable write/read/test
    if (fst.Properties(kMutable, false)) {
      MutableFst<Arc> *mfst = MutableFst<Arc>::Read(filename);
      CHECK(mfst);
      TestBase(*mfst);
      TestExpanded(*mfst);
      TestMutable(mfst);
      delete mfst;
    }
  }

  void TestIO() const { TestIO(*testfst_); }

 private:
  // This constructs test FSTs. Given a mutable FST, will leave
  // the FST as follows:
  // (I) NumStates() = nstates
  // (II) Start() = 0
  // (III) Final(s) =  NthWeight(s)
  // (IV) For state s:
  //     (a) NumArcs(s) == s + 1
  //     (b) For ith arc (i: 1 to s) of s:
  //         (1) ilabel = i
  //         (2) olabel = 0
  //         (3) weight = NthWeight(i)
  //         (4) nextstate = s
  //     (c) s+1st arc of s:
  //         (1) ilabel = s + 1
  //         (2) olabel = 0
  //         (3) weight = NthWeight(s + 1)
  //         (4) nextstate = s + 1 if s < nstates - 1
  //                         0 if s == nstates - 1
  void InitFst(MutableFst<Arc> *fst, size_t nstates) const {
    fst->DeleteStates();

    for (StateId s = 0; s < nstates; ++s) {
      fst->AddState();
      fst->SetFinal(s, NthWeight(s));
      for (size_t i = 1; i <= s; ++i) {
        Arc arc(i, 0, NthWeight(i), s);
        fst->AddArc(s, arc);
      }
      fst->AddArc(
          s, Arc(s + 1, 0, NthWeight(s + 1), s == nstates - 1 ? 0 : s + 1));
    }

    if (nstates > 0) fst->SetStart(0);
  }

  // Generates One() + ... + One() (n times) if weighted_,
  // otherwise One().
  Weight NthWeight(int n) const {
    if (!weighted_) return Weight::One();
    Weight w = Weight::Zero();
    for (int i = 0; i < n; ++i) w = Plus(w, Weight::One());
    return w;
  }

  size_t num_states_ = 0;
  bool weighted_ = true;
  F *testfst_;  // what we're testing
};

}  // namespace fst

#endif  // FST_TEST_FST_TEST_H_

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

#ifndef FST_SCRIPT_RELABEL_H_
#define FST_SCRIPT_RELABEL_H_

#include <algorithm>
#include <tuple>
#include <utility>
#include <vector>

#include <fst/types.h>
#include <fst/relabel.h>
#include <fst/script/fst-class.h>

namespace fst {
namespace script {

using RelabelArgs1 =
    std::tuple<MutableFstClass *, const SymbolTable *, const SymbolTable *,
               const std::string &, bool, const SymbolTable *,
               const SymbolTable *, const std::string &, bool>;

template <class Arc>
void Relabel(RelabelArgs1 *args) {
  MutableFst<Arc> *ofst = std::get<0>(*args)->GetMutableFst<Arc>();
  Relabel(ofst, std::get<1>(*args), std::get<2>(*args), std::get<3>(*args),
          std::get<4>(*args), std::get<5>(*args), std::get<6>(*args),
          std::get<7>(*args), std::get<8>(*args));
}

using RelabelArgs2 =
    std::tuple<MutableFstClass *, const std::vector<std::pair<int64, int64>> &,
               const std::vector<std::pair<int64, int64>> &>;

template <class Arc>
void Relabel(RelabelArgs2 *args) {
  MutableFst<Arc> *ofst = std::get<0>(*args)->GetMutableFst<Arc>();
  using LabelPair = std::pair<typename Arc::Label, typename Arc::Label>;
  // In case the MutableFstClass::Label is not the same as Arc::Label,
  // make a copy.
  std::vector<LabelPair> typed_ipairs(std::get<1>(*args).size());
  std::copy(std::get<1>(*args).begin(), std::get<1>(*args).end(),
            typed_ipairs.begin());
  std::vector<LabelPair> typed_opairs(std::get<2>(*args).size());
  std::copy(std::get<2>(*args).begin(), std::get<2>(*args).end(),
            typed_opairs.begin());
  Relabel(ofst, typed_ipairs, typed_opairs);
}

void Relabel(MutableFstClass *ofst, const SymbolTable *old_isymbols,
             const SymbolTable *new_isymbols,
             const std::string &unknown_isymbol, bool attach_new_isymbols,
             const SymbolTable *old_osymbols, const SymbolTable *new_osymbols,
             const std::string &unknown_osymbol, bool attach_new_osymbols);

void Relabel(MutableFstClass *ofst,
             const std::vector<std::pair<int64, int64>> &ipairs,
             const std::vector<std::pair<int64, int64>> &opairs);

}  // namespace script
}  // namespace fst

#endif  // FST_SCRIPT_RELABEL_H_

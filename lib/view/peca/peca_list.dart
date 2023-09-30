import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/service/peca_service.dart';
import '../../shared/components/ButtonComponent.dart';
import '../../shared/components/InputComponent.dart';
import '../../shared/components/LoadingComponent.dart';
import '../../shared/components/PaginacaoComponent.dart';
import '../../shared/components/TextComponent.dart';
import '../../shared/widgets/CardWidget.dart';
import '../../shared/widgets/NavBarWidget.dart';

class PecaList extends StatelessWidget {
  const PecaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Get.put<PecaService>(PecaService());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: NavbarWidget(),
        //drawer: Sidebar(),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextComponent('Peças',
                      fontSize: 24, fontWeight: FontWeight.bold),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Get.width / 2,
                      child: InputComponent(
                          hintText: 'Buscar',
                          onChanged: (value) {
                            service.pesquisar = value;
                          },
                          onFieldSubmitted: (value) async {
                            service.pesquisar = value;
                            await service.listaPecas();
                          }),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 2,
                      child: ButtonComponent(
                          onPressed: () async {
                            await service.listaPecas();
                          },
                          text: 'Buscar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Obx(() => !service.carregando.value
                    ? ListView.builder(
                        itemCount: service.pecas.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: CardWidget(
                                widget: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              'ID Peça',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(
                                            service.pecas[index].idPeca
                                                .toString(),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              'Nome',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SelectableText(service
                                                  .pecas[index].descricao
                                                  .toString()
                                                  .capitalize ??
                                              ''),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          const Expanded(
                                            flex: 2,
                                            child: TextComponent(
                                              'Produto',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(
                                            child: SelectableText(
                                              service.pecas[index].produto
                                                      ?.descricao
                                                      .toString() ??
                                                  '',
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Expanded(
                                      //       flex: 2,
                                      //       child: TextComponent(
                                      //         'Ações',
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     ),
                                      //     ButtonAcaoWidget(detalhe: () {
                                      //       Get.delete<
                                      //           FornecedorDetalheservice>();
                                      //       Get.toNamed(
                                      //           '/fornecedores/${service.fornecedores[index].idFornecedor}');

                                      //       Get.delete<
                                      //           SeparacaoDetalheservice>();
                                      //     })
                                      //     // maskFormatter.realInputFormmater(pedido[index].valorTotal.toString()).getMaskedText(),
                                      //   ],
                                      // ),
                                    ])),
                              ));
                        },
                      )
                    : const LoadingComponent()),
              ),
              GetBuilder<PecaService>(
                builder: (_) => PaginacaoComponent(
                  total: service.pagina.getTotal(),
                  atual: service.pagina.getAtual(),
                  primeiraPagina: () {
                    service.pagina.primeira();
                    service.listaPecas();
                  },
                  anteriorPagina: () {
                    service.pagina.anterior();
                    service.listaPecas();
                  },
                  proximaPagina: () {
                    service.pagina.proxima();
                    service.listaPecas();
                  },
                  ultimaPagina: () {
                    service.pagina.ultima();
                    service.listaPecas();
                  },
                ),
              )
            ],
          ),
        ));
  }
}

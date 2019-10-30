Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52863EA60D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2019 23:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfJ3WR5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Oct 2019 18:17:57 -0400
Received: from mail-bgr052100128081.outbound.protection.outlook.com ([52.100.128.81]:17392
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbfJ3WR5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Oct 2019 18:17:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJb/5+cY8PAdHEVDnTZDEy14OztATzHOk2gU4m7IfKs9sZpiqLEWjWkaj1Aua6VZ0RB5Z432Lv3OHspkCMo9HuQvWMFBjo4gje1Ig1rrNddYS7fCZXBU2teUFup3Paz8V3AA11avwJN9CrCVXHR3jVsv42u8qoXb5eNpCCM/x9L1SoFRBiVd1Td3JL8GqTL2Rc9MewRA2BpXa/TrXz6OW0Recb8sg0aqyrzBFiWsW0J5edRoG76f4HT08eszg9n4KmfnscJocPIQDcQPQK6k6T1x7fklgihJhovn+8liqqEexpq0SaY/boUqk4Li86uNxgdSupSRA2Mka1vmgoykow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N/MduBd8qUSLJ6ka0vhuPoZTnGlo1fQaj+/GpcnjWg=;
 b=Nb9b90QLY1Giud9WiUNdAoTL0XT3pRqhcgk35gz/jShAlCtUPnXLHhR4zJaPSKEL4mfxCo14fbDoUbTkGGQB1fPlpOn66X6M7FErxqEe2uB3oNNqTa6O+kWPSPhRgLZycYHJJl1M5ahlxOLx7xlf9S2PWLkWkn8unEI2jddE8fXgbBMEWkmcJ8B/acdByZbTSvqUwIyYSKw8Eb2osYaxrkiMdrY+3j5gwLdNDnkzAU6lGfacY5hy8bIIC+I6UgmHIAWJ/8imyn28+svfbNtYc0a6y5y7Qh6YhxAeokF+7Owf7cYadtLG7z1JYoA3ysGJjTSu838sv89/ZLNznn6Y6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=poligran.edu.co; dmarc=pass action=none
 header.from=poligran.edu.co; dkim=pass header.d=poligran.edu.co; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=POLIGRAN.onmicrosoft.com; s=selector2-POLIGRAN-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N/MduBd8qUSLJ6ka0vhuPoZTnGlo1fQaj+/GpcnjWg=;
 b=bCFCDJieEVvrHLrL8pgPnGVmQMz6QiBx62ZCReYyIjQBmzJ5G3JpiyzP8MS5cEkYPZfOxwFPLHmZR0DxRe/5QFIRfLQLpFBEv3cpBFSKdoL2knMZWe5S3gpvKd03W5q0F1eOJuVK/12ykXEP6nXOM0b+QKx6CcDnNPObmw0J5Jw=
Received: from BN6PR03MB3107.namprd03.prod.outlook.com (10.174.234.16) by
 BN6PR03MB2835.namprd03.prod.outlook.com (10.175.126.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Wed, 30 Oct 2019 22:17:53 +0000
Received: from BN6PR03MB3107.namprd03.prod.outlook.com
 ([fe80::4b7:7cfe:3c8b:26a1]) by BN6PR03MB3107.namprd03.prod.outlook.com
 ([fe80::4b7:7cfe:3c8b:26a1%5]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 22:17:53 +0000
From:   LEONARDO CEBALLOS VALLEJO <leceballos1@poligran.edu.co>
To:     "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>
Subject: Re: Spec.
Thread-Topic: Spec.
Thread-Index: AQHVj2PnbLxesBDnbEuf0bLS+YcBRQ==
Date:   Wed, 30 Oct 2019 20:52:12 +0000
Message-ID: <BN6PR03MB3107AC1AF8463F4726F5DBE6A3600@BN6PR03MB3107.namprd03.prod.outlook.com>
Reply-To: "gleltd@hotmail.com" <gleltd@hotmail.com>
Accept-Language: es-CO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR07CA0077.eurprd07.prod.outlook.com
 (2603:10a6:207:6::11) To BN6PR03MB3107.namprd03.prod.outlook.com
 (2603:10b6:405:44::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leceballos1@poligran.edu.co; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [197.211.58.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cbd0b451-7cb1-4b08-f75a-08d75d7b099d
x-ms-traffictypediagnostic: BN6PR03MB2835:
x-microsoft-antispam-prvs: <BN6PR03MB2835766D55F72D506C15A7E9A3600@BN6PR03MB2835.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(86362001)(102836004)(305945005)(62860400002)(52536014)(386003)(55236004)(3480700005)(43066004)(8796002)(8676002)(2906002)(5003540100004)(66806009)(74316002)(5660300002)(6506007)(6436002)(88552002)(6916009)(7736002)(55016002)(9686003)(8936002)(66446008)(81166006)(5640700003)(81156014)(66556008)(66946007)(64756008)(33656002)(2351001)(186003)(476003)(25786009)(14444005)(486006)(6246003)(316002)(71190400001)(3846002)(71200400001)(256004)(6116002)(66476007)(478600001)(10916006)(558084003)(786003)(229853002)(7116003)(2501003)(26005)(2860700004)(99286004)(6666004)(52116002)(7696005)(14454004)(66066001);DIR:OUT;SFP:1501;SCL:1;SRVR:BN6PR03MB2835;H:BN6PR03MB3107.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: poligran.edu.co does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyZhW2/4fc1D+vb9ZjE0Vb6KvTnzQPQO3m4SDrIpShdwtqxit5A0oVUPkHl4rtRKGA1AUylnfRm19hoBgoQBendlxGI8l9ptuHEqjjSoJzK+Wx3uXxK2h+oOZ7QJU9z1aK5nNka42L38trGPVcz/Lc1z9F3UYb2f9bbI6j1sRJF5XxpvMdRAUYGgFsTYJNVejirYs66RHBWeQ6l7FlPujVj2OnlPjZReu+12KDcw//SuJWzYLcsTmM1d3r4g7wUa/ZizH5IoqLrZtI4AzlCAM8FIM1EmrCqAFmbKhhcrg6RJehUT06xd+QIOKwuLGKKGAmn8lbjtGSevmJ8IJvCqDVttjFQCI/aW3dLIUrBOVHXxr5Nd9IvYyXbPU4eEC+Lnr/ytAAWEDaizd3n22q/rAUori1kPpF5s9pfQ+SlGFEu9gT2uH95n/qRKaSVKjKz5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E1D399080F97CB44B1DDFCECF4A28F74@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: poligran.edu.co
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd0b451-7cb1-4b08-f75a-08d75d7b099d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 20:52:12.0881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dd505be5-ec69-47f5-92df-caa55febf5fa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spuyF8l6ZRvkokOKlWFZnn9YQt6UYv6CdYNKFG523R9ntcWIvIyDj8Y7Zc9ZTUBeY+oJvM3O2JCngBeWrfAUreO9CBJSMDLgaiSD9dJ0byI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2835
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hello linux-tip-commits@vger.kernel.org

My company is interested in your quality product, kindly send your company =
latest catalog/price list for urgent order.

Leonardo(Export Manager)
Pacific Packaging Industries
Block 1, Suite 101,office land
building, USA
Tel: (791) 271-7458

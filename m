Return-Path: <linux-tip-commits+bounces-4551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0952A70CC6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292223B815F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD3C26A0A8;
	Tue, 25 Mar 2025 22:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HEBli0sb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA49269B11;
	Tue, 25 Mar 2025 22:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941255; cv=fail; b=TcmWdlRDTM3eU+6abmVRirtt1GZZ2nm8K02GVxPenzLBqJ5J8gXEQshrwFTJ4UOe1CW9HjzPlVcmYgkTjWL5NYYhXyZ6oMxvkaa7YLoVQhUSfy6IB3IPKNkkTa4BQB4yCuU1bHMwpdT7JudTu0brLBhFRCdzUT5F+k26fTUoFAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941255; c=relaxed/simple;
	bh=y4FAqTTsi/d3ygmeIh5KMccBP9Il3ZJbmCMLxorllIc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j2End/3JiYIRv2Bhn8M24wafPA2YGvMhuJoqPZ7IyWONNi6ZLDbfEauY25tK4jgwkXtoH+bNdvVI7KtRnuKCGx1FfQqCV/fCDXkbwGUwnrLWxJzmJHHQoqPyHIG6///AI8IQSZE0K4rfI49Ex4Vsq0V+teTOaIdHtW1LYUD92cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HEBli0sb; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIM1r2DOtgalPhvI4PB21NUMabwyn06NtbVu29QdAZbpzCImc7KB5UhoAIrcFXmcl3H3oVvRQawovwxXA0edC+792KJjjkwlWdolGYvwTT7WyzAxWcm0Nn5RQJ5KsIK4l1w7j0d64hlokUVg2KNuNArZpd59LHbbO2zN3a/kmRJP+f/g3aLINqsqIxFvwe/k8THknJUzqBZS+BqzO0RK/7iV7H1IDVjJ8VaqekChWOpbD5aNZ8NDYUcFQtsgCKsBAWhP7j2fg1REuQDDe1e7bkcu/vr81sVOnVuUZ4dWsz5TMlmrQ53dg89ruwgzvtOnmn3pd2B04O9LgaKwWEbBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4FAqTTsi/d3ygmeIh5KMccBP9Il3ZJbmCMLxorllIc=;
 b=lXMwOqlCy8FXoURwt5jiLa1r/VH+r45dl48tX7T61hsdnkU4aye+f82U5xUGLQzzIVkdErXz3++VoDShtX/8RsGOwycUVlReK0N87NNkLRVbMRiW3mXJ1tFIe34yOW8pUlQNwHA4l06tTX6iKmiDoN+ogV3N+O2ZJvzgOlJpRMm7jJEUsbkEi72iKW4hbKJPYYjWy5d2XrnHmObkc/AUjDjahrdekEjm/mUWVw8gqTUaTa92Pad/9duQ+ysa4z7IZFalOTcQAAGCIZYoZ97ryTK5QNWo8gVYQX/qqTaOK8hBOOCZCAmlHigmUK2wZFrPvbA8b++fOzM2TRgqeXQhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4FAqTTsi/d3ygmeIh5KMccBP9Il3ZJbmCMLxorllIc=;
 b=HEBli0sbD7JVfU5tbUO4J19w7pqu5BmGmhVo+c6Ex9ala/qI0DHQfeGHmHpDf/O0EjEyIL92CFDi0NkV3Ev+GiCgNOqLNPPl01licI1fVKiTWnFF68x4KJ2JHORr0HDd2A0XJHFhuy2qzB0z3aRpCEpM0pijxWJ/slfTopJvyMgJGSTK+b1hpURP+dEGamtl5zKIK3U5WGuxc4uxOWFpttExczsvI/enpZb7mjW4eZyUoDh1CWera2d18OBAu5dTbICxiK/b1Dx1LNjFE3dE061GCLZE8uPFBmD4Nsfonx+2clXuNNcBBO3ZzhN2XgwRgcl2oX8aerDUd/fvKx/quA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 22:20:48 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 22:20:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>
CC: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Linus
 Torvalds <torvalds@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [tip: objtool/urgent] objtool, nvmet: Fix out-of-bounds stack
 access in nvmet_ctrl_state_show()
Thread-Topic: [tip: objtool/urgent] objtool, nvmet: Fix out-of-bounds stack
 access in nvmet_ctrl_state_show()
Thread-Index: AQHbndKrl3IcFQNrpECLGvdcdG4zvLOEbKqA
Date: Tue, 25 Mar 2025 22:20:48 +0000
Message-ID: <1c9ca973-20a2-47b1-a156-ece2ef72e522@nvidia.com>
References:
 <f1f60858ee7a941863dc7f5506c540cb9f97b5f6.1742852847.git.jpoimboe@kernel.org>
 <174294059921.14745.13913646647268973086.tip-bot2@tip-bot2>
In-Reply-To: <174294059921.14745.13913646647268973086.tip-bot2@tip-bot2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5835:EE_
x-ms-office365-filtering-correlation-id: b653c315-a9ba-4393-8851-08dd6beb4b70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NElGYUpER25ZRXl4YVJTcFJvTnhOWlpkR2N5NUM5bWNwRUdHQWNDalNmUENX?=
 =?utf-8?B?SXlweUk4b3c3R0hvb1lYaTA5U0t0dmE3U1A2Y0tuUDJ6bDNnd0N5d0xQbVJa?=
 =?utf-8?B?cWdlRXAvc0o3M3d3WWxidWdrWXlPdU92RUlBVHdYVkZEeFdFNHdBeDU2eU5I?=
 =?utf-8?B?NDNtOVptWUFOb1poYkNQVmJnK1JETnlxN3hRZTh3ZHNyMXhlM2VoNHN6VGVh?=
 =?utf-8?B?Zk1UazVyY1VST1VIYUlwZDJBbGZUOExubGRnakdVdEk0VVlsek9haHVtd1E1?=
 =?utf-8?B?VDAxQ3NjMG5xekFyVUsxOVN4M0tlcU9nN2xrSUN1OEJScDNKL1JZYnpVeU9D?=
 =?utf-8?B?bkpMcERkTmxJUGtjZEsrT25uMWNJMmVrZ2FVeUlucDYwaWNHUDV2dVVBeWRp?=
 =?utf-8?B?Zm5QZWNCYzlEVEQ3RXcyYk1XcjRNMU90VzVSZ2l2QkhhYVBQUUQxbldpdXBv?=
 =?utf-8?B?dWE2d3NaUXVrdFVkQ255bkd0WTZtMDlkRFVpSDBxa0FkT3JHblBhVlR2N2Zi?=
 =?utf-8?B?UE1qWXRudnFWei9xVjRjakxaWVMvWU10S0dZREtmN0NNaW1iRmVYYVZOMFEw?=
 =?utf-8?B?WGc5NmxzdVFoZlFpeHNPa2w1aDRBczdkOHRvd2RhMVF0clFQd2FQd1FNTDl5?=
 =?utf-8?B?cTlVMDdRelBsQklobXVYSHFGQW1FNVBWUWkrY1lnV0JDcEVmSmVuZjIzMXZ1?=
 =?utf-8?B?ME9NZlVCRW0vMDIxT29aTE1HSHhOMG5lSE5mc1FpQ1NaWnJ2dHdNQjBHSWhE?=
 =?utf-8?B?WFBDNElWNE5jL1pQa2s5OTFoMGdndHA5M2E2YUVmWHJxTlRVNGZvUWIyVEI5?=
 =?utf-8?B?VFBlQWV6bHU5VkpUQ2VFT05HM080ZVZJVS8yRE1ha3RIWHZKMVJ5TnVuODds?=
 =?utf-8?B?SXh5YlRWend1NVlXYkRzWXFVaVNrYzlINzBWeXZTcFltUlBYWkw3bmxvWW9K?=
 =?utf-8?B?T0hKUEU3NmNUZm8wNmh3OU9CQngrS2l2bWY4UXljRlZPR3pLVUNYNUU0clE3?=
 =?utf-8?B?VHdrWVl4a3JwaDlSK2lGOFUxZzFGbGNzM1Y1Z0tWQS9MT0krS0ltd3ViZHZC?=
 =?utf-8?B?RS9PSnczUzRiV29MaWNwNlBseDU2N0FJd2ZlaUNIajRxUk45L1lnVDQyZ3E1?=
 =?utf-8?B?SzRKVFB4eE1GanBURDJVbG9MWUhuMyswcFhFdnFLTWJicitMblpnSHpBTHk5?=
 =?utf-8?B?djIwdW1naE9Xby9RcWlQWXdQa2RlaEdkelNGVDNQRnpNMzFoTUtGSlFoZm5y?=
 =?utf-8?B?RkM3ZWpWSFFka0tCaHZ1WXFSUEJsbHBRbWVRdENwRmN6WnNXdkFlL0tiWWNh?=
 =?utf-8?B?K0xZcy8vVEZUc0VwTXdUWWFZVk9IZFVRemVleEQ5RCtOMmhWZGI0MjdpMTQ2?=
 =?utf-8?B?NU9FOGRqdVJqNmgrMVpyeXRZQlNDaHF6Qm50d3BiWCtjUXZiU1lyRk4rN3ZS?=
 =?utf-8?B?MTlaWkRSVmZLZ2djUUh0akZaL1l4b1FiU0xrNWtVUkc1dDlJSlF0dW8vZnNj?=
 =?utf-8?B?UlJCaCtwa3dpZi8xSUp2TzVobVdtUkU2SGJsZ1FROWlEZmJxKzRONXg3dGdr?=
 =?utf-8?B?TUtlSHFIbEtTekhzTFRRd2R6L3lmTWEvRTE0V05kUVNnN3VZQWhOT0dROHJB?=
 =?utf-8?B?YUhyVmNMcGliY1U0OFh1SDMzdzFPcnVnSkJSa1JJeVVWc0NDdUtVMHpWK0Zi?=
 =?utf-8?B?Q3Rsb2tsN2NQaGtHYlBKaWF5NlI5M2IrUndSZGZnTHIvRDAvcmJDM2ZONWN6?=
 =?utf-8?B?VE9KUzQxRG1BVHBPMFlJdmZjbWZkdjYwVlFreUsxUXBZelI5ZkZDdWZFR25n?=
 =?utf-8?B?UlpaMEgzSG01dkE0K3JROXlIY3ZDekpWSXFKem9kblE4NmxMeXRGd1BLWDd0?=
 =?utf-8?B?UkNNbzBXYkY5d2RhdWxCbUxTQWRRc3ZJT2l5K2hSSnZlM2dBN3FhbUFUREVx?=
 =?utf-8?Q?PjNbMrzUGA5TdZAfRLBXRNhCzlTpaCZf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUowK2dhRzVyQmlBekxtUHNFZWtVRzhZZ1VRRy9RSDVjMjZleVpycElRLzds?=
 =?utf-8?B?UDFKZnJqc1ptczdtZHZPYVpHNG1GU3dFUzZzRW9pRDRpR0cyOHp0Wi9kSnF4?=
 =?utf-8?B?ZDZtR0ZNSk9rQkt1ZHQ5Y0FKMXhFTDBObGdsaHM0Y3VuNWZnNUEyUU5UWnls?=
 =?utf-8?B?K3g5QWNycVpPUmF1dWZObzNVQ3JOZkwxbldxbHpqSlpGU3RZNUpBQ014RGVQ?=
 =?utf-8?B?czhHV25hZTlmYTRLa2ZIRmJpbFNzSWtGNG1xZERRbDhqMjJGNHR6NzVHMkhY?=
 =?utf-8?B?ZVo3VkloRlg0V241MkhvWlU5c3RRV2pxSkFXQlp2azhubXIyRlhHdVMyOW1X?=
 =?utf-8?B?cmZlNk9HYnVOMXVudzRHRFVhTXhyOEpnTng2NkhFNmZSN1JGaEs1Zi8wZ0RN?=
 =?utf-8?B?TnZZM3BsbDQzMEZVQUdzUzZKRU5NTEt1TEc3V3BHbjE4MFJWVWlVZnFEM1hx?=
 =?utf-8?B?dGdXSVUzZW9TZC81M00yVHNmaXhXeS95RjNVSUJCZnVCUnNUbktEYmJQenJ1?=
 =?utf-8?B?TlJERlB6SGRnOE9kWkVXU1o5L3A5SmkzNEhsdTFwTE9nM2V5b0JNN3VaSElL?=
 =?utf-8?B?WUZSd1paR1JOWE4rSjRsYVZMb3c3MWZPcGczWGdPTHYzQjJrWTY1QkFrbWh1?=
 =?utf-8?B?L3BXUmlCZnNUTjNaZjVCSlVlQzcyYU92ekw3bi9GcngwUkRJc0NkL2lMOEwr?=
 =?utf-8?B?V0tvTVVkYlhEM0dYM21rdG1NRUVVeEpvaDRDeGNNVTZkcHZGYnlLQlFNcWJM?=
 =?utf-8?B?Nm1lT1dOVFdWc0VraVpyTjY2bEZ1UmRxWk5EUFlyaHFBV2tDdFNCV3cvTlBt?=
 =?utf-8?B?R3djZGNUek5IdmFFQ3NueTB1dzVVVzRsVjBjTzRsQXBUWkZDZmdFWjJURmFN?=
 =?utf-8?B?V2ZSZWpZTGg5Y2ZxVXFyZzdSYXZXMFBycDJGOGRMZlg3aWcrenZQak5zUGdl?=
 =?utf-8?B?SHA3eWtpK1JsdloyQTZXYnk0a0MwS1ZlRUJwOFJ5aUc0RGZaQjdXaUpLdXJG?=
 =?utf-8?B?VEtaNXpWNi9BNTQ2NVhQeWF1YVk3TWtEa0dBRDRieElUYXRNbWhGczI2UXBJ?=
 =?utf-8?B?OS94b3pkMk5GdWdNeVZTMjFOYU9ob01hOS9vdVQxL0JDbENrNXRESDJ1bWtT?=
 =?utf-8?B?NUUrNEhYcURVaElBR1RSR2NCc2xLSWt3WlZJMXdDb0hFcUJEY1VVOWlCd3o4?=
 =?utf-8?B?WXBnT01OczJ2ZS9UZldLQnZlelZnNkZtTXNPV3NvUFk0dFRieWl6U1kvdGpv?=
 =?utf-8?B?RmRkblhSSHBCcS9qNEJMMkxNVStaQzN5OEhxaW51ZHQ2dWV3WDBaRlpLWXZ1?=
 =?utf-8?B?VkwxYXFBMm4yNW1kTThQM3NiZ2RHOTdNY0xnYnJGdmRkbzk0Y3hLT0VpTmha?=
 =?utf-8?B?UGV3dFR6Z0ZVenpvQ1JpcW1RS0p6ajlFY0h0RHJtYytBMFk2TFJkcENoM0Fs?=
 =?utf-8?B?bTdjNmd1ck90RmZYejhxU1RFTldZNUFBUjl6MjJWS29HRUdacFhhZ2Qrb2Jk?=
 =?utf-8?B?OGQ2UkdSdldmN1k2d0cwRmx6SWRYWUJwYXNGdkpkMnJ1RnNIbXlLSzJEUlhX?=
 =?utf-8?B?SmFraHBBUUVZRkx5VmFZS1h4ZkdNeWVkUC9YSE1hbjNCbFRRaFZxNi9yRTda?=
 =?utf-8?B?czZ0Q0FLTkYwV1Q0TDFZNzBMWkVUckRoWmdybGZSbHNCUTdRWHd4cUtuck5u?=
 =?utf-8?B?Mk9mSzNZTDlMenZpd2tmbjZLQmROVnVvOEUzS0EvUDVNbnFnbloxVWNmMHVF?=
 =?utf-8?B?aE1QcWxzbHplMFZ1TzZHQ2ZWc1hxdGtDK1Z5Rk9vSms3Vm1wY3NHSTdYYkti?=
 =?utf-8?B?TmFsRUtCcExYQ2RsWTNsWWtuYURDd1RGSXI2SzZnOE5oVkhKMTFIMVprSnFm?=
 =?utf-8?B?cVM3TzlVaVJsdDVvdmNFV0FBamYvVEd1QW9zTFRyNDdpSGdXOU5KYzVidGQr?=
 =?utf-8?B?Wlk5dGY1NzVxNFhKL0tyUkFRUGl3dkFibnA3bnBJUUxNRSs5b0VHUmJkVkIz?=
 =?utf-8?B?emVOYmJNN2VjYzN3RHluSkp3OFRvNTdzTGMyWDJTRXFKQ2t5TDFDYmxqNjR5?=
 =?utf-8?B?bmhHUERJclk2RDZOUkJjWUJsWWt1bndjS1doT1ZxR3QxeUZodlNtQUtZTVpx?=
 =?utf-8?B?RjFCNFFXUzdtUUZLL01RaC9YRHVkUWs4K0FOeFZrdDh6ZlM0S2NtRHdhQVlh?=
 =?utf-8?Q?sBx0n0e9PH3ixiT5rCP/KAXOC/FyoHhfjPrG54Lvo6qR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <278AE616646FE741A89AC4765FB34734@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b653c315-a9ba-4393-8851-08dd6beb4b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 22:20:48.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMx7kkXSVHAZrevijaUqWR8/sNoqM6VLEW/PhrPoeVdtPVf2Wiw7hxK8JjSiDwEL4ULy8KSFuKtndeUjRizTng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835

KCtsaW51eC1udm1lKQ0KDQpPbiAzLzI1LzI1IDE1OjA5LCB0aXAtYm90MiBmb3IgSm9zaCBQb2lt
Ym9ldWYgd3JvdGU6DQo+IFRoZSBmb2xsb3dpbmcgY29tbWl0IGhhcyBiZWVuIG1lcmdlZCBpbnRv
IHRoZSBvYmp0b29sL3VyZ2VudCBicmFuY2ggb2YgdGlwOg0KPg0KPiBDb21taXQtSUQ6ICAgICAx
MDdhMjMxODVkOTkwZTNkZjY2MzhkOWE4NGM4MzVmOTYzZmUzMGE2DQo+IEdpdHdlYjogICAgICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvdGlwLzEwN2EyMzE4NWQ5OTBlM2RmNjYzOGQ5YTg0Yzgz
NWY5NjNmZTMwYTYNCj4gQXV0aG9yOiAgICAgICAgSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtl
cm5lbC5vcmc+DQo+IEF1dGhvckRhdGU6ICAgIE1vbiwgMjQgTWFyIDIwMjUgMTQ6NTY6MDUgLTA3
OjAwDQo+IENvbW1pdHRlcjogICAgIEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiBD
b21taXR0ZXJEYXRlOiBUdWUsIDI1IE1hciAyMDI1IDIzOjAwOjE1ICswMTowMA0KPg0KPiBvYmp0
b29sLCBudm1ldDogRml4IG91dC1vZi1ib3VuZHMgc3RhY2sgYWNjZXNzIGluIG52bWV0X2N0cmxf
c3RhdGVfc2hvdygpDQo+DQo+IFRoZSBjc3RzX3N0YXRlX25hbWVzW10gYXJyYXkgb25seSBoYXMg
c2l4IHNwYXJzZSBlbnRyaWVzLCBidXQgdGhlDQo+IGl0ZXJhdGlvbiBjb2RlIGluIG52bWV0X2N0
cmxfc3RhdGVfc2hvdygpIGl0ZXJhdGVzIHNldmVuLCByZXN1bHRpbmcgaW4gYQ0KPiBwb3RlbnRp
YWwgb3V0LW9mLWJvdW5kcyBzdGFjayByZWFkLiAgRml4IHRoYXQuDQo+DQo+IEZpeGVzIHRoZSBm
b2xsb3dpbmcgd2FybmluZyB3aXRoIGFuIFVCU0FOIGtlcm5lbDoNCj4NCj4gICAgdm1saW51eC5v
OiB3YXJuaW5nOiBvYmp0b29sOiAudGV4dC5udm1ldF9jdHJsX3N0YXRlX3Nob3c6IHVuZXhwZWN0
ZWQgZW5kIG9mIHNlY3Rpb24NCj4NCj4gRml4ZXM6IDY0OWZkNDE0MjBhOCAoIm52bWV0OiBhZGQg
ZGVidWdmcyBzdXBwb3J0IikNCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2Vy
bmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+
DQo+IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gQ2M6IFNhZ2kgR3JpbWJl
cmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IENjOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlk
aWEuY29tPg0KPiBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24u
b3JnPg0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL2YxZjYwODU4ZWU3YTk0MTg2
M2RjN2Y1NTA2YzU0MGNiOWY5N2I1ZjYuMTc0Mjg1Mjg0Ny5naXQuanBvaW1ib2VAa2VybmVsLm9y
Zw0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWtidWlsZC1hbGwvMjAyNTAz
MTcxNTQ3LkxsQ1RKTFFMLWxrcEBpbnRlbC5jb20vDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS90
YXJnZXQvZGVidWdmcy5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9k
ZWJ1Z2ZzLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2RlYnVnZnMuYw0KPiBpbmRleCAyMjBjNzM5
Li5jNjU3MWZiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2RlYnVnZnMuYw0K
PiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2RlYnVnZnMuYw0KPiBAQCAtNzgsNyArNzgsNyBA
QCBzdGF0aWMgaW50IG52bWV0X2N0cmxfc3RhdGVfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZv
aWQgKnApDQo+ICAgCWJvb2wgc2VwID0gZmFsc2U7DQo+ICAgCWludCBpOw0KPiAgIA0KPiAtCWZv
ciAoaSA9IDA7IGkgPCA3OyBpKyspIHsNCj4gKwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShj
c3RzX3N0YXRlX25hbWVzKTsgaSsrKSB7DQo+ICAgCQlpbnQgc3RhdGUgPSBCSVQoaSk7DQo+ICAg
DQo+ICAgCQlpZiAoIShjdHJsLT5jc3RzICYgc3RhdGUpKQ0KDQpMb29rcyBnb29kLg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K


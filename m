Return-Path: <linux-tip-commits+bounces-2889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B859DA4D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Nov 2024 10:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C95B22958
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Nov 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E2E192B70;
	Wed, 27 Nov 2024 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="inC5x2sg";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="inC5x2sg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82217A5BE;
	Wed, 27 Nov 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732700076; cv=fail; b=Prc9H2rtqaqGiJG0pMcj24Zi/0oQj83nym3k8znc4VMY+l05pPy3MIwjcN4+lJ4pzmqpIyRJ9UcBJhj9ysnOZuB2ftDC9zT/sx7v7/ro0Yxup3O1PNYuYUgAxmwPqtiFdeHnivwzxfcJ0zkVCttOFQZ/R7tzPj1O7uHWtl199So=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732700076; c=relaxed/simple;
	bh=Gs9+uGolFz7dgnv0AeS39X1Cxcj1dOg9hUqf5Lg8G58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neqFV0Q1iSkcQIkJgftom4L7n46InEli8ki4GCO6oNpd4dOR6HMndBWoaUdeDNtU7YE6+mxNBuNJo7r7L0JWQUSfZK4Nx/Ax3+Uvend+NQ6nQiYt5xZ6IVKxX0dhHdQKgtqZTjVmZCYiGS3ggaI3TaNHVbaXPsHuIBtgsIyvjh4=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=inC5x2sg; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=inC5x2sg; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Oxq7buB/aZnItN9kMUA+Ky01lbJrbJk9ZPBGhGIzsgeU8KxHACdyYYeTpHdrvEtq6lAkQiiwx3t+GrymNCQ2opbI9UBSAdA7TWzYDQ3pmIwBnEPASkq8/FdjhWidoOA+HsHaRQOowcaVaQ8UBo36GteWEvhezUNK8EiPSnPFS1AGTEsA7VpvdYhb8EDAwW0L/bJuIdDPFm5hxXIjSL/LU40h6hIrZDTwbJ26lyYq134V8Mfyo6NZTsLREbp3G3GJTKU6LlcgpYX8F3qzqsszi0Ol/TyRHi/HsKMnu4F71UfWjyVZOo0/k4lNQwu4gV5wp49+BJspyMvsLw9pZ8wpHg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4Nkbqw5toRpl71c0XDzwnkr2wA9Knxnk0dI94laoA8=;
 b=ojzuk5L1/GpIbCqu+gqxAo+C+MV5xP8J3mQjtonR+T7mH7nmcaVua2W9TB5thfMqAHu+HAcw7oY5ebYH+N5QU6C/rQU2VWiB7F29FGuuDFs2oKS/rVa2pSvuREkSzecRLl2tibTpvsTsqOyL3VNh5tVXWu3iRzDLB1UmOyQWp8eUXRYITAvbVWkPUYPmoKTLmxxJb1TJgykYW0y/WychI7/PDc2ITtG3XdjOdXhLTYN2YuXFb0/9seUMPjWALmGEVw78E1peuqQCMriRK9da2xQO8KVOz3hzgPjZdHU4UbU/JFijdulTbnJqp2nxbCXYLPlpPwgBpUW5hG9InjM0sg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4Nkbqw5toRpl71c0XDzwnkr2wA9Knxnk0dI94laoA8=;
 b=inC5x2sgsCcYQjUKQTRK9mmnzCbjydwSgu00xLjXCX2ZrqQbjGDvmYkNZ/PHjToNsvocxO5tGjwU+oZ2K9e5EBESvG88Jm7+lqiWBr0+Zo+L/zOld5j3VdwXMCfRa0131L+uOn9w6+YlW00EvUA1qhFucRNVm8JDnKPfiaddnNo=
Received: from DU2PR04CA0087.eurprd04.prod.outlook.com (2603:10a6:10:232::32)
 by GV1PR08MB8132.eurprd08.prod.outlook.com (2603:10a6:150:90::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 09:34:26 +0000
Received: from DB5PEPF00014B8E.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::3a) by DU2PR04CA0087.outlook.office365.com
 (2603:10a6:10:232::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12 via Frontend Transport; Wed,
 27 Nov 2024 09:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B8E.mail.protection.outlook.com (10.167.8.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Wed, 27 Nov 2024 09:34:25 +0000
Received: ("Tessian outbound 3b1f0cd68b0e:v514"); Wed, 27 Nov 2024 09:34:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4e70c0c514aa87a6
X-TessianGatewayMetadata: +oE4pLo8obGwxdFdZru+DfVooZh5lEBQ5tg3JiL3fC3z072vdMNhG0Ke0VEG9DKQXn7Stok3Rjh+ISvTpgKWQN0BGC6RSva/9YCeuazkavnuEy7yh7YfZPBoheAszSmVkb7yJkx4Nda3GuhuPPA5Iz9p8Rm98HRh1oQVUmGO0JA=
X-CR-MTA-TID: 64aa7808
Received: from L2a01c8508933.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5E3761DB-5480-41C4-B5F8-51EBE390A7B4.1;
	Wed, 27 Nov 2024 09:34:18 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L2a01c8508933.1
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Wed, 27 Nov 2024 09:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoEppAx+m81vp2zNkTBg8MMfPfgBqZpIJ5l5JA+gwTAXNFNn7nk/ra7uc9XSC61i2lMAQHoPTxOAJBvMrWqp2P9yOBtBhfAPjxD/+MwJWeeMElit5Z9yMdLTuIrK0lB7iu3xuU5a0cRLeuZJjuab6vBpz+UORT9ilVqHrFQ49w0lA9UJYqAqHidPis6PQW3vi6kmzDK/1viBzISrkNEMIt2YunAywOeI+QVLiXWSWOLBwBY6ZUnoBB8/JRPJd9Zcizx6WxUKx9QHeelI/obRPxXRu28liF+60RqYd/N0v74/K0ZQIsA26w6deJhB8G6hVaTjlkCird0VuofcxPtD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4Nkbqw5toRpl71c0XDzwnkr2wA9Knxnk0dI94laoA8=;
 b=lnLf97drFnYy+1MyFU3qnbeQc3Z5PxHi1YdubW5u077gkFzSEnNMicmySh9yHOizb234kXX0MgzQc9DjvjT/YTIKXh7YBo3A+OtlOyXjHtoUkF9KxFOk6HwhCG5SfUSdgr7zn3hxmSkKpFJs0FFDqrnyEmbLz8atRz/jLWLGIeQarWlObMHz7KjM64p7+O0zv3xbIkPniviF/i1YQV3/WLgPEcPKrY7HcibfxavoEfrya4rlmA+f4/qyr+hC5iBNElrcsqzhaCdE4Qbu6v9dofCbLn2vTVYqQsk8Qn8qQfj8Ae5drSZhXYgskzQ/F2bTrlSv6dc+z1w3yT+hor3xTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r4Nkbqw5toRpl71c0XDzwnkr2wA9Knxnk0dI94laoA8=;
 b=inC5x2sgsCcYQjUKQTRK9mmnzCbjydwSgu00xLjXCX2ZrqQbjGDvmYkNZ/PHjToNsvocxO5tGjwU+oZ2K9e5EBESvG88Jm7+lqiWBr0+Zo+L/zOld5j3VdwXMCfRa0131L+uOn9w6+YlW00EvUA1qhFucRNVm8JDnKPfiaddnNo=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com (2603:10a6:102:8e::21)
 by DBBPR08MB10793.eurprd08.prod.outlook.com (2603:10a6:10:53d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 09:34:15 +0000
Received: from PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d]) by PR3PR08MB5852.eurprd08.prod.outlook.com
 ([fe80::f44:d113:1c29:825d%3]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 09:34:14 +0000
Message-ID: <30f13deb-7dda-4a17-ab88-f386377bc30b@arm.com>
Date: Wed, 27 Nov 2024 09:34:12 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/core] sched/eevdf: More PELT vs DELAYED_DEQUEUE
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
References: <20240906104525.GG4928@noisy.programming.kicks-ass.net>
 <172595576232.2215.18027704125134691219.tip-bot2@tip-bot2>
 <ee2feb3b-0a1f-4276-b6fd-f36014654cbf@amd.com>
From: Luis Machado <luis.machado@arm.com>
In-Reply-To: <ee2feb3b-0a1f-4276-b6fd-f36014654cbf@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0242.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::13) To PR3PR08MB5852.eurprd08.prod.outlook.com
 (2603:10a6:102:8e::21)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PR3PR08MB5852:EE_|DBBPR08MB10793:EE_|DB5PEPF00014B8E:EE_|GV1PR08MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0267b9-d55d-47fe-7f5c-08dd0ec6af15
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SXlxeUpnQ0dwRTVXd2QzcE9BNW0wUG9JWVhqVmVYaXFuR09ucDAwWDEvdXo1?=
 =?utf-8?B?ZjV0Rm5oU0llYWI5TElJYVFDaG1Ua01qRmhKZklOOFhkNHlhVUV2T2RtRkN2?=
 =?utf-8?B?aitSd2prRjAxL2o4dkxrdXAyN3U2aWRLYzNZSzlvSjQ5U3ZCK1VRR2NGWjQ4?=
 =?utf-8?B?aVlSOWlRSzZMOGxkdThtL2duUTY0WnI4dEdOQldCVUFTMzNmOXgrWHRkN3hE?=
 =?utf-8?B?YVVaTm5UUVV3c0JUOXVhU01ReDZ3azBIaUF2c05KNTFwTE13ZWQ1bmphOURm?=
 =?utf-8?B?Z0UwMm1OWXJQVnBRcDVUK1F0NlFPMjdldWFSODJMYk1vbGxVUFR6cnZ2Nnhr?=
 =?utf-8?B?Kzlrc3ZUeGVsWWZxNklEUEx6Mk5MQ1NhZy9nM0RBT3hBd3dhOWZ1N1crWFlJ?=
 =?utf-8?B?dWlQNk0vamlGZWV6bUpSZU1VbHlremUyUVgxcUI4blpIcU5lbFVWU0M1SVA0?=
 =?utf-8?B?bWZWT24xbGpUUmxCTzlsTnBQS0ZaeEsvL3k0QVM3eEJQY2YzT3pIMVR2cCsy?=
 =?utf-8?B?bmVTY1c2RjRpWkhidlJXSDhRa0pYWWxIUkdZL1ZIUnIwSzQyVWM2OHBEOXQ3?=
 =?utf-8?B?UUh0WkNxUSs0VWpOdkd6MFhhTU1GeWNlcHhlUkV1dnQrMHpXOXBQQkhIL1pi?=
 =?utf-8?B?cDJKTWwwb251Wi95TzgvY1pvYkVmYUhZd0hnR2NaM2RKelBhbWVzQkx4bThz?=
 =?utf-8?B?TXFsby9YUTlITjJZUHhvUkFCSlcra3dSMktyZEprbForVHlCVlBGOWJXK0hZ?=
 =?utf-8?B?VjlPWlB4R01KbkhBeU51ejZCUko4UHJjYWNUSEtXaWQ3cXh3ZHBYSWpCNWhh?=
 =?utf-8?B?c21mVkE1SnFQZElwTzFJc0EwRTBJN3BQMk5McEI3RW9COWlxT3J5RDFLYnlF?=
 =?utf-8?B?MnlIS0F6cm9qU2xmajlMa3UyODBpeHF2Sy9mbGR1MVUxVExwaDAzRHE5ZGo3?=
 =?utf-8?B?K1YvZnY3b1hRZmJwRFRnY2xoMjFycUROM3F0eEFSWlNrL0hKS2N0VlBsbDNQ?=
 =?utf-8?B?elJBSHlDZm45SVBUSE9VUm1mdm1BbGwraStYbHZYNVkvZkx3RU5hOFY1NlF1?=
 =?utf-8?B?eVkwZDhPaFh5cjZkZmNENS94dVBWM2cvVmFnOEhpRVlhUFkyZjhBa3VSM2NQ?=
 =?utf-8?B?UnpQYkhIUVRuWjR2MGl4VzluMHZaZHdSRktEdVN3V3lsamYwc3FVWVVmKzRO?=
 =?utf-8?B?amN1dG5rZnlWdmM4bzRyVUFMZUlSMDF1K1ZZNGtETUdIckJsN2tOSmZOY0lu?=
 =?utf-8?B?MGd4QXd0TlFkeDEwS0piVklqeHYwN1hEaEE0QkpRMFRqYUxzczk0S0pPeStn?=
 =?utf-8?B?NGxwenY3anZJRVVORUZJUjY1dUkrNnYzVHVzWkFDYkZqb2l5QlVNczJMWjRp?=
 =?utf-8?B?RFM4bktmYlRqdnB1SERaRktpMUtYQ2FBTFc5N0pDQWFwMkdTbkxIWStJbzE4?=
 =?utf-8?B?aHh6TW9JNzlqS0Q1N0g3QUVkVEpLMjc5ZmoyUWJkaVdQOWZ2NG93YW5KOFBV?=
 =?utf-8?B?YkdjMHZqcWJZUy8vWnIyandiUzdmcEVNdXVlbW9LWkhaTnpxQ3oyMWVnMkE1?=
 =?utf-8?B?Y3hjRkxTK2VrTWZCK2J0K0NUdyt0YmJGT2liTDVFM0NiKy9VR3g2a2VIZGxX?=
 =?utf-8?B?eHZMN0d4ZFV6ckRsVVpCamN1UU1xMUxqdFJ3YVVpekZTeUdGWUhXb2xab3JS?=
 =?utf-8?B?bHl5VHpGRXIzcHE0Yk13OXRka2w0K1JqVGRrMHVDSFpabk1Kbk8yMnloeUtZ?=
 =?utf-8?Q?l42xExyX//Zl54MkswIP8MtPS8ZtQGUbW/RtZri?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5852.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10793
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:102:8e::21];domain=PR3PR08MB5852.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2a2400ef-4bcd-460e-b621-08dd0ec6a7ed
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTBmbDNmSlpvRzRURWthSlBXT2NRM2ZlcmpTeThPV1JuMGZGOHFlYjEwNUFt?=
 =?utf-8?B?T3FGMnBNOFpoNWtaZVdKYUlxWDZGWEVpbWx4SGF5QmRiUGpjRTBma3dNd0Rz?=
 =?utf-8?B?V25PODhQWGl2YVVsTTBRL2Y2Q29oZEdmbGhaTys1Q2FFdDlvYUVoL1ZFNkZh?=
 =?utf-8?B?YjlQS05qVUVhZVRMbTJVRzVtRVFDS0tyTnR4VlNJMi9rUDEybWlPUVByTzNO?=
 =?utf-8?B?UUgxU2xOdzg3eTFQei82blhXK0NVMFNFdkhwRFMyQmw2b0ZialJmWElNdUtG?=
 =?utf-8?B?S1JZT1NSV2lZODhGOXdoT01idmt1UVFBYU9VVlN6WVljL2ovZ2dkais3dE1U?=
 =?utf-8?B?VzQrZmVPL2JBaGVPT0xoRFc2Uld0RHFLYzZvVFVaTlFCUjIrNGxjTktMdHR2?=
 =?utf-8?B?SzRWNUVqUEFLbDRlK0wvUktNaTg4LzRuaEtLSU0ydkxZK2Yyb3lWa3BpTGdC?=
 =?utf-8?B?VTcwcnFVdjZaR2ZmQWRkU1F5QXc1RldJM004ZHJLd0grck5jcHRpZ0w0WkJJ?=
 =?utf-8?B?L2VPQzV6TDVTS2c5SlhiRW9peXF0bndXdFR3Tms3bytGWWpzSjVIdzJ6SnlJ?=
 =?utf-8?B?VXQzcS9KTGRtY1VnenVqVWc4VXRXdy9Ob2VoUVVOMFZlVDNMMDVHYlN4NkhY?=
 =?utf-8?B?bjZZeVZUZUFicG56RldnU3lIRkg2aFB1cVV2MDd0MnZUNVY1SG12cnkwaTdD?=
 =?utf-8?B?WEZjajhZcGREb1BIK0RzSFdKenQydUozUmkrVHVwRFNFWERobW1YaDQ3eW5K?=
 =?utf-8?B?SUxxbnNpT3RVUHMyTVJtWlkyNy9DQmt3c2w5K3lZMHI5Mlc4cnlIOGdpS3l6?=
 =?utf-8?B?VW1hd0FMelIrN2RzajBsbHZpbGozSVBRYk1Lc2l2N0xxQWNVK2dObkw2ODFP?=
 =?utf-8?B?cW1NbXI1OGx5QlZGcUtmKzluU20yeGw3ZFB6cmd2RFJ5eWdWOUFteU52NzRS?=
 =?utf-8?B?NTBqRkE4MGI2UkVTZXdKMW5lYitPdXhaaytGeWs4VVZLS0VEOTlFakFFZVNz?=
 =?utf-8?B?cEZKVHNlOUVoekdOWlZRd1NkdlRWM0oxeGIvMTdNV1p1VEhrYUNFdVpwMnpM?=
 =?utf-8?B?UlhrT255VlhTc2pRUWxqRVFHcEEvcU44MFlNa1h1emFNTWFucUZjcFBlVHh2?=
 =?utf-8?B?UGx6SkV1aHVmTitxMUx3bENva2xkUWd0bXkxSkplTWE5UkZrVnE3Z2kwNmty?=
 =?utf-8?B?WDU1RlF3Z2p2YllVSzdwQ3pNaGJlTjI4bnRrR3NSVkxBVXhiRTdTMU9zdG0w?=
 =?utf-8?B?bnhDNk4zZVBobm1sTFBtU3RIVFJHemNSMFdnU1lEREE4MmRhZW1pUHI3T3Bu?=
 =?utf-8?B?ZTFOVmRNMU52RUxObUxEbVRHaURrczFoT1VkUFFqeTBoNFZLUFNSR3pLdmlz?=
 =?utf-8?B?NlY1T0lhK3hERjBwakhoeWtrVXVOTTl2NFBiVVJvc2hVRmtraWxWdGNlTmpY?=
 =?utf-8?B?YUQ1Y3czUEd0TDNRWDF4SFY0OFVCV3IzTmZlR2NCU3NSeGtFSVFKV1M5VXpi?=
 =?utf-8?B?WDlKcVlwcExzRWU1dHVneDZCRXJTVHp3ajl3TWgyTzlSVmRGdUpmZEF6bTlK?=
 =?utf-8?B?MlBldTR4eUUwM2ZZYzVlazVHc1ZKNy9QNUROWVBySzNxeEoyS1JOQUVtT2hI?=
 =?utf-8?B?MUhEMW80Mnh1RkZTN2QwbkR0R0ZodWhtZlByQ2d0a29zUHBPcXJzcVU5UjFl?=
 =?utf-8?B?clFOYVNzalE1ZU9EWmd3dG9Gd29mUStmZGF4L0VPcHpSMlBDNm9BYkwybFFT?=
 =?utf-8?B?bU1vM0w4R2dyVzQ4ZDMzRk4vOGZZQ2wxSnpWRjdMcm15ZU1xWkF6NmFqUnVq?=
 =?utf-8?B?cWNpVzJ3eW9tdDZ4S2tpWG8ybnFYekpkWUVyTXlsOHhXcGh0UmlrMkJscVh3?=
 =?utf-8?B?YnoySlRDanUza1dpb1ZjTDJsbzRKakNod1owUFhhMXR6eXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:34:25.9588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0267b9-d55d-47fe-7f5c-08dd0ec6af15
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8132

Hi,

On 11/27/24 04:17, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 9/10/2024 1:39 PM, tip-bot2 for Peter Zijlstra wrote:
>> The following commit has been merged into the sched/core branch of tip:
>>
>> Commit-ID:     2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
>> Gitweb:        https://git.kernel.org/tip/2e05f6c71d36f8ae1410a1cf3f12848cc17916e9
>> Author:        Peter Zijlstra <peterz@infradead.org>
>> AuthorDate:    Fri, 06 Sep 2024 12:45:25 +02:00
>> Committer:     Peter Zijlstra <peterz@infradead.org>
>> CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00
>>
>> sched/eevdf: More PELT vs DELAYED_DEQUEUE
>>
>> Vincent and Dietmar noted that while commit fc1892becd56 fixes the
>> entity runnable stats, it does not adjust the cfs_rq runnable stats,
>> which are based off of h_nr_running.
>>
>> Track h_nr_delayed such that we can discount those and adjust the
>> signal.
>>
>> Fixes: fc1892becd56 ("sched/eevdf: Fixup PELT vs DELAYED_DEQUEUE")
>> Reported-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Link: https://lkml.kernel.org/r/20240906104525.GG4928@noisy.programming.kicks-ass.net
> 
> I've been testing this fix for a while now to see if it helps the
> regressions reported around EEVDF complete. The issue with negative
> "h_nr_delayed" reported by Luis previously seem to have been fixed as a
> result of commit 75b6499024a6 ("sched/fair: Properly deactivate
> sched_delayed task upon class change")

I recall having 75b6499024a6 in my testing tree and somehow still noticing
unbalanced accounting for h_nr_delayed, where it would be decremented
twice eventually, leading to negative numbers.

I might have to give it another go if we're considering including the change
as-is, just to make sure. Since our setups are slightly different, we could
be exercising some slightly different paths.

Did this patch help with the regressions you noticed though? 

> 
> I've been running stress-ng for a while and haven't seen any cases of
> negative "h_nr_delayed". I'd also added the following WARN_ON() to see
> if there are any delayed tasks on the cfs_rq before switching to idle in
> some of my previous experiments and I did not see any splat during my
> benchmark runs.
> 
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 621696269584..c19a31fa46c9 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -457,6 +457,9 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct t
>  
>  static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
>  {
> +    /* All delayed tasks must be picked off before switching to idle */
> +    SCHED_WARN_ON(rq->cfs.h_nr_delayed);
> +
>      update_idle_core(rq);
>      scx_update_idle(rq, true);
>      schedstat_inc(rq->sched_goidle);
> -- 
> 
> If you are including this back, feel free to add:
> 
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
>> [..snip..]
> 



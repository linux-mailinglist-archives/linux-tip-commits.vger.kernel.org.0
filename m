Return-Path: <linux-tip-commits+bounces-2863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C3B9C92F9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 21:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84320282010
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Nov 2024 20:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE731AAE2E;
	Thu, 14 Nov 2024 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dqkiXWG5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DP5W3Sm5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9919F42F;
	Thu, 14 Nov 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615082; cv=fail; b=it9X/N6O6PNsQ4OIeBOsn5jNzUyni2Uj0RdG8FOO7TkVXoCWCFqFtkTeO+e59XxlyUQt7NtmXAqTuTumluh28Tddc8NsyxI1pG0FRIXMWTD3KqTu3NGV/q59XSE9SCvXdjzX/47wcmumSfaBUBVw9BNcgPC3mF/NyvEeWrRwL+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615082; c=relaxed/simple;
	bh=oae94iipFQjB44Eug6LteYJSc82Ww0L454eY3w6/2B0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rY5cRhoII6jh6xh5acv5/ruqh3EJeECUkQcPyX2XyrRPtoks3/is0k/i45El6H/u19TzFG2Uj6ZexruqGHHG0TH3eKUCr2paL4NSTFEmlCWb+sQIhEs/BXoI16BaOmHK76YsDmWjP9gZZ1XrB2gec9M2cI6zo/Ad8541zmhqgOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dqkiXWG5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DP5W3Sm5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJfeRD005479;
	Thu, 14 Nov 2024 20:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GJnr6yQifPljnR5uBbMU4ONMsUEG9bzadkQxriQ/xdM=; b=
	dqkiXWG5UHH2+qjTJlz6FjGayPcBHxpXGSLUbgiUAhw+HdDI35caLouCmUXeh7lU
	p1vGuefxT6PHL4pPv3vzHU5LSSk+masktnwTu6WSIRLjoVl1az+PmyFfWwt3JyQQ
	eSGDO7PFsVQYHMCKsLtBvS4l+hK4+Q8fNxqnpe54Y/CVSOgIqpDw3zWw+kZbzQaC
	tvsKCr2VPedDumz24sn+hp8pTyH7BH+18wLkai5RlQZ06HMO6ZRBSp2F7cTkCPYK
	nCiQpaVuVBcxrjil/LDMExkV2TBvFg+ZuTWGDxrd1TNM1JqFy6zoP0syB6GvXIhP
	n5orQwS3fgfhqFPHc20PTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5hyts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 20:11:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEK0K75022894;
	Thu, 14 Nov 2024 20:11:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw1t483-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 20:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK2E1bnbVPQrMxcVmczKtx0kCodqYx9bxiMAVeKUCLxJXAgklN4VIRQlm07snjfk/1hFZXIqs4Xpu5lnYKuOxlUhoCHZVRHGak9aLTpKb+0b0iAyni9ZX3K1iatGUuf+PIQJdEMYrV3i5Fl3cKQVhNO9kUZ2KQzGQvQJoStGPZ6lEux81yWF3SCUD4CJt/CcfcRXqU55OqK5opwjxQ5PqMsB2zYxJH/OyYsYyEZHax+Hkdud7GtOfPf7CdN0JI1m7aSGNZexsHYgdq2yoysQsOT5yLUUIsFTbQ1ae8cGpmrRCQ4f3O2FR7u4eU2J57nWSpKwJB/mTLICxWSWK7bEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJnr6yQifPljnR5uBbMU4ONMsUEG9bzadkQxriQ/xdM=;
 b=GCPW58LofMQkP7FCJqkQeT5KNErpk9a8TlhNbVfZz56SBDJqZFYBQeggPI4kC3Ug/fU4tjUwfxIr0UaOuMs2k600/E0YGkTI/c7TomlmkG11Q5m01ehLY594VSm/6qalAjFFqnoU6qjVXnXeFehyZX0pE9+VLyIhX2PFNuuf3TUvhvDlDxEjeHjLfHuYatjng/tR3Ni8apHVz4FSOthgG9BuyGi7DvrRqQEM+XARDudFm1wCtWPpdqH1Jtmt2qC4Je3YKKZ1Eqc/MqYJlon6I3UVrj0uvRNf7tlCD+WrsLaneb1tG1m+vtEQbwhEAsJTsqlu2oxCXG6Xrd2u9wvdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJnr6yQifPljnR5uBbMU4ONMsUEG9bzadkQxriQ/xdM=;
 b=DP5W3Sm5IHAekejqDTAaN63fQNxz0WB771HmZmcR3Q3ttPtGnew636FgP1ApduJ2bQeWcxtGn3He41oqi+w0hfudYfo0FBfZ44t9yCLZ1Hx+KEcvW7JYFKxEsagghjZ12xrsN4l+K/G99m2N+L8UicMK0Z7OAMY6xBWgKSSCBxg=
Received: from CY5PR10MB6011.namprd10.prod.outlook.com (2603:10b6:930:28::16)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 20:11:04 +0000
Received: from CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e]) by CY5PR10MB6011.namprd10.prod.outlook.com
 ([fe80::3aca:a3f6:e92f:782e%3]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 20:11:04 +0000
Message-ID: <ca5c6d15-7205-45e0-96a9-e78ab2a52b45@oracle.com>
Date: Thu, 14 Nov 2024 15:10:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Cristian Prundeanu <cpru@amazon.com>, linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bjoern Doebel <doebel@amazon.com>,
        Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
        Geoff Blake <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
        Csaba Csoma <csabac@amazon.com>
References: <20241017052000.99200-1-cpru@amazon.com>
Content-Language: en-US, en-AG
From: Joseph Salisbury <joseph.salisbury@oracle.com>
In-Reply-To: <20241017052000.99200-1-cpru@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0274.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::22) To CY5PR10MB6011.namprd10.prod.outlook.com
 (2603:10b6:930:28::16)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR10MB6011:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4767bf3c-323a-4d4d-2adc-08dd04e87763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUxBckg2amxxUmxEUm8vdXFENUFDejhXcUpZaE5QNTk0dXAweFloQWEyK2d2?=
 =?utf-8?B?UThpZm9yaHVtaXNVMlpEeWM0S0xpdFlIQ1EvOHJiQmhJT3FrNUloQU1YdG1o?=
 =?utf-8?B?OU9iT1pMTUtXUVRmTHFXWkxqeXJwVGIyQU9FZTJHSCtYVmNkaDM4TVEvM1FF?=
 =?utf-8?B?WUI5N2hyWWswR3kxTnRMUVlLSnQzVkU5RnRkbmJQbjJvVDl3bmxORENSVFJB?=
 =?utf-8?B?UHhsN082V1JRZ1pNVFJ2RHdGUERrcVR6czJoQzM4bVJuMWwzSlBJQzA4VzRz?=
 =?utf-8?B?YzE5MGd6OUo4STBnYkcya2l5cUlpSUxWK05XeGZDd3hwRGFCSWlUcmtQbTRz?=
 =?utf-8?B?R2J6MjViMnRYVWhTRXp6cExnK0tvQ2dpZndqdysyNXh6eFZIZkhjUUlDTEdo?=
 =?utf-8?B?YVVNckRDSjBXWEJUM2t2OHV0NkRzckY3VjBLdHVWNFExb0laU29KU21qOENm?=
 =?utf-8?B?eWlHU1g5SnJZL2R2WGhkYklJZW9rM2ZVUElEQ0VsOElnYzVUMm9zU3J2RHFh?=
 =?utf-8?B?bDBhWmpKcGhVdlZ3Nk5zSi9MWDN1MWYxUERnL3JlcHBCNFUvWGFnNTB1Wk1l?=
 =?utf-8?B?R2I1WFhiaVpYanIzeSsvS04xNUoybk5NWEpyaUJpYWl3UnR3Skd0ZnZLUEc0?=
 =?utf-8?B?aGNBYXFHU0VXZG5uQmFCRXRyU3kxWk5LTnU2U2VzamRNMTJvbGpBbkRZbFV4?=
 =?utf-8?B?MTRlSU41clpLaUlVanFaTlJId0RnSFN3WnpqcmlWMzdpN29leEt2TWlPODFl?=
 =?utf-8?B?a3dTYm52YmNhejdPamIreUJUUll2aGJSeHQrYW5YOXdySXB1ZDJTc2ZaU3ZX?=
 =?utf-8?B?QjgxSGp0emJ5bVl1OFcyWTlWUWFCbEJseDhwRzBHaVNNd0M0dVdGQUtGNjBW?=
 =?utf-8?B?Sy9ldGNLK0hPalk4UkI2STJvRFBrNFFTc1RNTzh2a0lVdnk2WnE5MDMyM0tU?=
 =?utf-8?B?SUltcytHYm4zeU5ocVluNGx4a1FiZ3BWU2xqQ3JxMDBmcHdZZTRoS1ZkT2FN?=
 =?utf-8?B?VlRCTjNMVVNqM0ZobzJJN3p5VmhWb3pRRzVqSXNZSXM1cGlTcmtJZ3JZSEdY?=
 =?utf-8?B?cmtxV3U1WndXaWV3MFN4eXRCdi81eUxpT2Ezdi9rcGpDR2t6bDZtMklPUkVh?=
 =?utf-8?B?NUlySGl5T3pjUWR1djQ5OElxcWhiRkUrTlQxRUhGYVV1NmNId2VZZzNoM2JB?=
 =?utf-8?B?OHdxbS9HVkVQY1YvUjZyS2E0Snd0OGVEc1V6VmJXbmZuNjZKeFFrTk0zcXVW?=
 =?utf-8?B?ajZpeXlaWHFIV3FWQWlCREhJVjcxMTlacTFYU0J1WTR2bk9jeE94Z2dpY2lU?=
 =?utf-8?B?VXNDMkNDOG1zNldSTVVqMDV5MWdTZ043c2JDY1pzTkQ2bFRVRWxFTVMwQWty?=
 =?utf-8?B?OUI3RXRaVU5MYTcwNjJ1aVROR2ZQTVp5a1RHQWtWT21ja2ozaUwzbTg5eWY5?=
 =?utf-8?B?cC9EVGNjR21Sd2FvTnY5U1ZmZXlPTXczSUo4YkRHdndlSTlwZnZnM0E1TXV3?=
 =?utf-8?B?UEVvcURFSTM0d2I5QXN5eHcvVG5ERnJWVDBWdkNxazYxVHNLMFBGWVhwUklO?=
 =?utf-8?B?bnJ6RXI0YmlxeWZSZFRIS0FYYnNaMlFMdGthVzBja2liOXJWa0J2UE1ZeGMv?=
 =?utf-8?B?ZWdUeUlYUjg0S1dtZzNPMEhGOUZiQkpMbndCWWFWZWFUQkxKK3BzY2ZLR0c0?=
 =?utf-8?B?bjcwMlo0OVVIaUhIa3MvYTViRUEwVEhkZzR2ZWxjNnBGUHhqdXNKU2dwUVh3?=
 =?utf-8?Q?1PK3G3hL+um9g92mMR6+pU73XfujfNadSBGDwUs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR10MB6011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlRnZ2IveWZDSzVYL0xFdEsyZkMyNW1VM09rZGNYMjMwZXlGWVdhWkpUdDZ3?=
 =?utf-8?B?Smg3ZUhXTTFpc1R3TkUxOHE5YWVISVFKY0d0MUlMeTBXNkRZWXJlcUJBU2RH?=
 =?utf-8?B?Q0NGMjNNQnFQMVdOOWYvNGkvOC9mTzhKck12YTZGYUZVWCtEaEI1Y2ZjU3Jp?=
 =?utf-8?B?N2VNclUyZEsvaFgwY05JMURaRjZHVStMakVOOE9JQkVzM0pGSXVsdjFxZ291?=
 =?utf-8?B?ajlBU2FRRit2ZEJ5a1ZTcy9GYkhob3VVUHQ3eFo4bXI5TGxqeW5IcEl5cnlD?=
 =?utf-8?B?QlBBVldSbDhTcjJFS0ZjZG8rY01yZ0dUTXlxa2JCNkNITzd0cFpxc1gzRFht?=
 =?utf-8?B?a1dnSnhEZm1ldnc2Ymdoa295SG1uMGJHbTlCdDFnd0lvVll4d01RRkQxdXdG?=
 =?utf-8?B?K1BDRXRiQjY2UDd1VlFXcmRJendNcDFRMlVRQjFrd2xsajI1YVdxcUlIOHhP?=
 =?utf-8?B?WU5neDJKbWl1RWdpYUk5Q0tmVUtlSElXSTM2ajZIZloydlRKcFl3b1N3M1FP?=
 =?utf-8?B?TzhtQ0dON1hmZ1Z1STc5c0hCbXZaa3dJK2FBR3JZSTFnV0xpQmhxc3dOR1d3?=
 =?utf-8?B?T0s1aCt6THNRR3BYdGlXVE5jdExsSDcvUjNUd0xHQ2Q1dVppT251cVJwTTJY?=
 =?utf-8?B?d0h3RVltbFlwTU8rS1A1UngwRlAyZ2pDVFZmY3h2cllZcXY0UzAzSWNxeHJP?=
 =?utf-8?B?aE0ybzIzRCtCMlVkT255M3FzdG1tMXhXZzhVYmhQSzEzU1k1TUNFL05TcHg4?=
 =?utf-8?B?VGR5bTVHMmgvbnU1dVVYVTR4UWN6UzRud1pFYm1GNUFKcEpneGp2RjNoclkx?=
 =?utf-8?B?RlhVL050QWhpd1BkbmhuTFoyVmY3WGxRS1NzVUhjZ21OMDk4TzNUMnFMWFVN?=
 =?utf-8?B?cFFzcitKV0V0QzR3ZUJOQ0V6bnB3TW9uemE4M2I5amFlcnIvRUNqT2tBZzRW?=
 =?utf-8?B?em5xMTZURnFwUWVqUXk5YjNmSGpVWjFHUlZac0hHNk1oWEg1MHRFdEhSTnpB?=
 =?utf-8?B?cG15N29FaS8wSEcvbldHMWFVQU1wQ05yWGJRQ3RKWG1Qckx3WDRjRktKZTFN?=
 =?utf-8?B?bUxjdkRycWVRL1JSa29hK2hnUllmck1CRThRaWQxMVAvc1JUZ0U5K3c2ejcy?=
 =?utf-8?B?WEpYMTFMOUlzRFlJWGhlZ0dya3hueG4wd2VzdWhWTTg2dG1LdXNhTVJBbGZT?=
 =?utf-8?B?U2xiUk9zMEo4WjYzZFNKRHgzNGlwK0Q1SlVKSjFwMHpHSk9vVnlRMnpzSldK?=
 =?utf-8?B?anRnYi9wZmdnKzBTRjlXVml5MVdoeEdkUzdrZXNKdU9VTnpHSVdRMitvMzYx?=
 =?utf-8?B?cC83SjF4MDlLQ0ZFbi9jdmpGZzBSWEJmMVo4THNjQWV6MkpsSTZLazkwSTA0?=
 =?utf-8?B?TWFObmNmVkt5ZElJSFVSYlVRWEx6VUJDcndhN1hUNGF5czBvaCtSOExLTkVV?=
 =?utf-8?B?OUpkNmMvQkxzemR4NExDU1dCLy81WExWZXg3d3FlNVpvWElNanhNZktWSFRl?=
 =?utf-8?B?RzZEMk92T0hKQTJjOWRuRlRjUk1jeExVUXBSb3lTZFROT05qZjU4bHhTWWtv?=
 =?utf-8?B?elVJdisvUVk0R1JYUWF0T01xYXp1ZmFMUDFIekJaMTU5Mmx0MUY4NzRYUy80?=
 =?utf-8?B?QTNGMDJ4OFhZSVZhYnp3aEgvWGErR3g3S1g2ZFVhUnlaMkRzQnYxNWtibGdF?=
 =?utf-8?B?V3JjZlFMeGJqc2NndVNkcUc5dC9UbFVhZ0dHZmhvOHdGelBmd3RXOWJML0p5?=
 =?utf-8?B?YzlCVFhPa1EwSXI2aXZSYjFYVklTN3BRTXQyeUhNcldMbjhsWGxkUFJ0aWZC?=
 =?utf-8?B?LzFBL1MxOVdqOTB1Tk5BQ1FSTW5EZmd6MStuTCtraUV4RGZJOWpmQkxXTThk?=
 =?utf-8?B?Z0doSXVmNUN0bURUdlFRb1BaRnY5Q1F5RzFaUzA1ZkVyWGFZU09odld2MTRh?=
 =?utf-8?B?QjhwUk9pcjFweVlXYjVEU3B6S2pHMGNpeVJweUc4ZEd0WlAzcGtrZUpONkJS?=
 =?utf-8?B?RVNSSTN2SVl0V0dJNHNBNnNJZXc3ZnFRZzhBWkxweTMvNm85TDdZbnljTWZZ?=
 =?utf-8?B?NWR4aldRdURIQmVvRG5pUWM3Unkwa09WckFneHBFWnAzYU5aeFhJaHVVZG1j?=
 =?utf-8?B?UlpnMUZoYjFwWVA4YjdIUFBpOVBqOTZvOXNYNS90b2cxWVh5RWN5SXpWVURO?=
 =?utf-8?Q?OdrrzDt+pkPmAEWTs6xjlCg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ecgYh7nIuLf9zKxPDMDyLdO9wq77b0s1eEtMkQPxl3BGsOmcCHsZLBF4bJJVmlpK3jR6RbXiehXv3I02lkvLwHcpx81eX/bq8vG/MPOcGiJioHwLnRESMP9d7JEJvG5B2Xxc4nUm3bfhOBLz4cIYAI061jjpauaRkT2nzqJ1l3jz1b3a0z7+jWQ4+TqS4TQhzEw8b9LjgpkPXRK/ueclOVnoAN8hsNlOW7blxtj527iVo3jp5tRqCQ4G0DezWOOhyWFQ+oWdihTSWfcQRY+knsKFQd546xgKALRH6ErNY85BXl4yNZC+0JiOhnRd00FxbWGCsrSG9RflW+/bU3AcYpMtpNqeO+3NVK/wLOsBcLaK5jEbUziSBD/4NJsSSiTO4B70ESGaMERoAX1Y5uc+7LnmYqKlPJBIY76zmek6tYjY8V9p1pCSEj4ZJlb/gD9CK+H95rJORTzrCal7QMDNDvvlzxcfQWd8sAqetqBmv5ulRGKy+4h39GyiOm92xJw0oAvyqJB7zrbXfMqte7nceM4fwW9dxyTrtmOFe8SKzn+k+wsol6fM0ynM4Yv+M2E/9PM/fAPakMmR7WUx8ymyFdpSYAKxrUSwlG/mxXx2lzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4767bf3c-323a-4d4d-2adc-08dd04e87763
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:11:04.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNzvymuOGDqlu9DdRl98IJzBvP0o8PRPt8bHqeNw2Zqfmc/JpVPEBdNocX1NnpxH3dhbbjs9LYhZLzDK6dVBEKJc6KoYJWWQq3hqYyIILSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140158
X-Proofpoint-ORIG-GUID: bEOSYXTvrwA7vkXUbJqZPJ7gl_PCCWE9
X-Proofpoint-GUID: bEOSYXTvrwA7vkXUbJqZPJ7gl_PCCWE9




On 10/17/24 01:19, Cristian Prundeanu wrote:
> This patchset disables the scheduler features PLACE_LAG and RUN_TO_PARITY
> and moves them to sysctl.
>
> Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced
> significant performance degradation in multiple database-oriented
> workloads. This degradation manifests in all kernel versions using EEVDF,
> across multiple Linux distributions, hardware architectures (x86_64,
> aarm64, amd64), and CPU generations.
>
> For example, running mysql+hammerdb results in a 12-17% throughput
> reduction and 12-18% latency increase compared to kernel 6.5 (using
> default scheduler settings everywhere). The magnitude of this performance
> impact is comparable to the average performance difference of a CPU
> generation over its predecessor.
>
> Testing combinations of available scheduler features showed that the
> largest improvement (short of disabling all EEVDF features) came from
> disabling both PLACE_LAG and RUN_TO_PARITY:
>
> Kernel   | default  | NO_PLACE_LAG and
> aarm64   | config   | NO_RUN_TO_PARITY
> ---------+----------+-----------------
> 6.5      | baseline |  N/A
> 6.6      | -13.2%   | -6.8%
> 6.7      | -13.1%   | -6.0%
> 6.8      | -12.3%   | -6.5%
> 6.9      | -12.7%   | -6.9%
> 6.10     | -13.5%   | -5.8%
> 6.11     | -12.6%   | -5.8%
> 6.12-rc2 | -12.2%   | -8.9%
> ---------+----------+-----------------
>
> Kernel   | default  | NO_PLACE_LAG and
> x86_64   | config   | NO_RUN_TO_PARITY
> ---------+----------+-----------------
> 6.5      | baseline |  N/A
> 6.6      | -16.8%   | -10.8%
> 6.7      | -16.4%   |  -9.9%
> 6.8      | -17.2%   |  -9.5%
> 6.9      | -17.4%   |  -9.7%
> 6.10     | -16.5%   |  -9.0%
> 6.11     | -15.0%   |  -8.5%
> 6.12-rc2 | -12.7%   | -10.9%
> ---------+----------+-----------------
>
> While the long term approach is debugging and fixing the scheduler
> behavior, algorithm changes to address performance issues of this nature
> are specialized (and likely prolonged or open-ended) research. Until a
> change is identified which fixes the performance degradation, in the
> interest of a better out-of-the-box performance: (1) disable these
> features by default, and (2) expose these values in sysctl instead of
> debugfs, so they can be more easily persisted across reboots.
>
> Cristian Prundeanu (2):
>    sched: Disable PLACE_LAG and RUN_TO_PARITY
>    sched: Move PLACE_LAG and RUN_TO_PARITY to sysctl
>
>   include/linux/sched/sysctl.h |  8 ++++++++
>   kernel/sched/core.c          | 13 +++++++++++++
>   kernel/sched/fair.c          |  5 +++--
>   kernel/sched/features.h      | 10 ----------
>   kernel/sysctl.c              | 20 ++++++++++++++++++++
>   5 files changed, 44 insertions(+), 12 deletions(-)
>
Hi Cristian,

This is a confirmation that we are also seeing a 9% performance 
regression with the TPCC benchmark after v6.6-rc1.  We narrowed down the 
regression was caused due to commit:
86bfbb7ce4f6 ("sched/fair: Add lag based placement")

This regression was reported via this thread:
https://lore.kernel.org/lkml/1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com/

Phil Auld suggested to try turning off the PLACE_LAG sched feature. We 
tested with NO_PLACE_LAG and can confirm it brought back 5% of the 
performance loss.  We do not yet know what effect NO_PLACE_LAG will have 
on other benchmarks, but it indeed helps TPCC.

Thanks for the work to move PLACE_LAG and RUN_TO_PARITY to sysctl!

Joe




Return-Path: <linux-tip-commits+bounces-5157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CB9AA6AC6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 08:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938711BA464D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 06:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53293264F88;
	Fri,  2 May 2025 06:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NSDYrYRZ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87317264A9D;
	Fri,  2 May 2025 06:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746167607; cv=fail; b=TQU/v7r2Bw5ga9Wnul/jfqdAjq+GBAD5ilxmOQnxQ5y3puJ7rUC8cIqDf6s3uiSkadJGySWAG3lks/Zw59VNPtsnSnD6MEffBGei0+y4uTDMtE7Zn/bEid6abwbhYEiR3hO4hwiTVDILXoCNg4ySze6tEtxgs6zxpt3BebfWoDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746167607; c=relaxed/simple;
	bh=I2rrhybQ9iH6Jo1eIC+GODKeOMkrycAM0D0x8Au0Wn4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=GODZdryfrFAxl/wlV9Sxt/cTB3f/06WZJgim+b+Bn/Juq4VxDrqhZxVlic6KuS+/8ZWwgmfJGoWiX0GA+A7L9hhv8XBIxp4Sbr0Dimc1aZg4k/Vj8ThWN1nHVF1Z56U+wTSm/1h2CMUsypMZimJnHzjMfP0wd9c9OOSUsurSMaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NSDYrYRZ; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsiT1arWRjL1UTiRprvWZ0dtaNkKw54UDhrCHhX+J6w8vqVwlhDU4VCA74ijZuOkifzpCov6H33Jv4NmSfIGk3UQzRjSvaehGzKlQouiJuUrSYyBQYPqnZBESjACxkb0E+kEEkB+B88SIUYcKsXYqUQ/0K5z1fHmJOM/tcPEtbL8Ku4JDKwQNAXDluUvc6y4xSWEZzrPmHhO5Re+3i6q/2iCnArXvOJ0Rt+3KIUd6QPwbhLs1atA0dgTGd9EAAjn02Z93rdF0IjboE2ursFbtVDgHRPezpvdei/uhGLNk/9hqD6Sd8S2q8sg+bHTJH4g5rBTZtXvXVpgkTa4WUndKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK4WmrIeb2b5bvnykqexAOgdy3PvAb2i9pydo2nq594=;
 b=NOv31shlRm8c8YmcB3naUwWluPMyYEUqQQkGA/sZm99hQHKIi4+lhhoxYufpSRSn+IdOg7rrFtav0SqUmEpt7Z5Z0i+jkl0GwLbnxZSQFKHZGt3SPHShmtwboi4PGehWHS6Oze+mbRc2QGrsTgrjAMKi0VSFK1geN6WKxDsK65X09xsHMRTq98CPIyOeiSyVU43dTtGRkM1Ohp9b3t1iXlNDJ1w7fEqIoyb84rCFc4gI8apDwqzDCqDfkAjg/W4+7NsxMf22QuUJk9eoqlCHIZC0hjv/cBLKi37vF7fAEgO3cJfz1uOtwJiXitYz2L5v2yS5IwGDHX/Wevi25BMK7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=amazon.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK4WmrIeb2b5bvnykqexAOgdy3PvAb2i9pydo2nq594=;
 b=NSDYrYRZrxOSssi4S8D3vEtHgSPfZ8rEQ62YVEKZFDdDp8vT6yxpRHXza/x/eBdo/0oxsPxray3GKSzqan1DXJS8CsXsMwgikqRMBOi5mYVJVMTZue8UhaEF0bPckZorJNymxzIqouwkocxNNdSZwFw59YCt0lV8V+k0hW3mTLs=
Received: from BN0PR04CA0027.namprd04.prod.outlook.com (2603:10b6:408:ee::32)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 06:33:21 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::9b) by BN0PR04CA0027.outlook.office365.com
 (2603:10b6:408:ee::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Fri,
 2 May 2025 06:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 06:33:21 +0000
Received: from [10.85.37.104] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 01:33:17 -0500
Message-ID: <7d3bd258-fa45-4e85-8700-90203bacdeea@amd.com>
Date: Fri, 2 May 2025 12:03:09 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EEVDF regression still exists
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: "Prundeanu, Cristian" <cpru@amazon.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>, "Saidi, Ali"
	<alisaidi@amazon.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"Blake, Geoff" <blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>,
	"Doebel, Bjoern" <doebel@amazon.de>, Gautham Shenoy <gautham.shenoy@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Joseph Salisbury
	<joseph.salisbury@oracle.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-tip-commits@vger.kernel.org"
	<linux-tip-commits@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
 <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
 <d875adc0-744e-4b1f-a1bf-7e051298a0ae@amd.com>
Content-Language: en-US
In-Reply-To: <d875adc0-744e-4b1f-a1bf-7e051298a0ae@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: fef9ca9f-86d4-467a-66e4-08dd89433bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3Y5Z1A3VUM5MjFHcllOb0RyMnJ0dy9aNXYwSHl1cStnaDFrMlErUVh2SklS?=
 =?utf-8?B?SGNyNU9jZkdKNmtoZ21iQ2dlMko4ajVOL3YxTmdDa2pOMzVndUM1V1VqdjAv?=
 =?utf-8?B?aG9CYzdkS1g4WnRqV25XczVyNEljbGUyWHhPSUd2UzRsL3luZEFqY0VKQXZE?=
 =?utf-8?B?cWEvL2MvSnlIaEJ4clVpOXZKeXM0T3hHQUJIR0Z1ZFlhU0wxSmRteTdXcytq?=
 =?utf-8?B?THJxeC9Da1hJNi9Ga3p2VzcyRUZybE1JY2dWTUtVQkFMd3NWTDJWYm5KSUxH?=
 =?utf-8?B?SjRJMnZGUjBYV2o0Q2I0T1FvcnllT3FsbkhoVG5UWlA5dzZZQlAyL2IyNk5T?=
 =?utf-8?B?VVFaRnVMamRxSVhCYWVLaFNHY2FFMU5RbFQ3d1BJbHUrNGM1N2EwRDFRV1hF?=
 =?utf-8?B?RElYZkw5dk5EQ2IvQlg3cm93RnFBUG5QVVZFaG1FbGdyT2s5cG5NVmFyeGlC?=
 =?utf-8?B?UEZxOHRuSk1pY2JGVjltTGQvaVJGVzNMdGtVNGwwMFNWZDBmdDlMenhTUkEy?=
 =?utf-8?B?M0FjRmJIamdiUUlRd0JTZWFkWEI1ZzVMOUw3UDliMWVreFBzbXkzVEN4YTFT?=
 =?utf-8?B?K0RmQWRsOUhjc0J4RUlnd2VuSzZCVU9VRVVadHpmaDJEZ1R3NEpDYlYyU1Ax?=
 =?utf-8?B?M2NGZmNncW5sWmt0Zy9kanRLd2YxaERIbCsxNGJTTkFFRjI5dWdyUGY1bVdQ?=
 =?utf-8?B?c09KK3R6T1o3a21DWkhVR055OHAyM3FjTk5jVkVqbXNleDU4YVFYRmV1bGc3?=
 =?utf-8?B?bXBzMnpzWDJRbUY5RXlYWXgybDRNZi92WTRxamEreE14d2hNSzI1cUxRTWJp?=
 =?utf-8?B?VG1iVEtsamNnRXNuTC9iQ1RudE5VVVZDWk8yUFBVL3phZTZJc3RtT1BvcjBE?=
 =?utf-8?B?R081YnlodjdCM2NTeXhja2RrWnJsYXNHMWRMUEVBYTdHVm8yZ0R2Y3dtc3dX?=
 =?utf-8?B?UmZPWTFTWGRBNThHUFp0WnFmeUdwdUZncFBDb2M3MWRSa2UxV3YvYmlwWEI5?=
 =?utf-8?B?a0hEeklTVkdlZ29FQzY3VFhzL1NrMUFBT2dVbmZxamIreUd6YUNSbUN3Ukh5?=
 =?utf-8?B?Z1o2dDk3VlZWMkhpeDZlemw5dWcvTkl0dXdvYlhkTzM3Z0JWbW12SFZSUFUw?=
 =?utf-8?B?WTFZY0ZWc04zVlNDNm91M2dKb2gzL0xGK3pxbG1VK3J2TjE0aXFwVUhmYS9n?=
 =?utf-8?B?eUxUencwTzdzeDRNZDNqZWt6SUYwN1BYSHFpcEhudG11aXJSRmllLzRjSjdq?=
 =?utf-8?B?UzZpV05tK1V3Z0xrUzZLMDd6d1c3ZE9zT0JpUFFNWDNVeFl4MlkvdjZJZE02?=
 =?utf-8?B?a2t4TjIwb1RnYXhQWTBPS1hyd2hDU3ZBazB4MjdHSVJ4MmN3UkFIb1dIdGNW?=
 =?utf-8?B?VUZVNERpblN5QjlESHc0cjVHL1RJOUZNbWZ4Mll4amxMRVdWOURXSmVaTlkz?=
 =?utf-8?B?cEZrM09OSUR0RTR6Y3VXVnByNXZ3QWtlNUZJUk1hNmw0Ym5DUUhJVzJ0c1N4?=
 =?utf-8?B?aVJXOXk0V25hTFNRbFhva1duMTlVNjMveW5XSHpvU3puVFplSC9qUytwK0R3?=
 =?utf-8?B?TW82NlZjRmxkRDZFR21LNlhSZjNGYm9jRFVhYWpNQ1MxR3JNU001cWU3bVJH?=
 =?utf-8?B?eE5ETnRlVldiQXRqTWVIVkdvSmc0cmRRRFN5dHNDVGV3MGtCcDY3Z3NlaFA1?=
 =?utf-8?B?WUtGRlZKKzFTbTBMZGxCTUMrT0dNUTVtc0xCZlE2R0xKNzlQM3NSY05ieXBP?=
 =?utf-8?B?UDBVYVI3MGVUMmtwbEJ1LzNqeGpLVlZ4M2dVNEJ2K2NtRUNaWjVBOVVicjhY?=
 =?utf-8?B?d29PaE0zemFYd2o4K2tFNzZBQXorUnhXdWQ5d0F6SUlmNVlzQU5DNWhPYXBq?=
 =?utf-8?B?b2JEYi9jd3M5V0oyYkVyNDN4YTE3QThWTURHTkRubEsvcUFBMGErVzJBTTRD?=
 =?utf-8?B?Ny9CdW5qOXNkZFZnVjN5bnYrd2c4U3c0QTlkc1hiTlBKVGRxaDhiVkZWajFP?=
 =?utf-8?B?aWpCcE1wTkl5WHlTYnBkR3pUWHY1Y3FobGZtYWtjSlNTcStUeWFsVUd1YXlF?=
 =?utf-8?Q?l8GHtl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 06:33:21.8456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef9ca9f-86d4-467a-66e4-08dd89433bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

Hello Cristian,

On 5/2/2025 11:26 AM, K Prateek Nayak wrote:
> Could you also provide some information on your LDG machine - its
> configuration and he kernel it is running (although this shouldn't
> really matter as long as it is same across runs)

So I'm looking at logs at LDG side which is a 4th Generation EPYC system
with 192CPUs running the repro on baremetal and I see:

[20250502.061627] [INFO] STARTING TEST
[20250502.061627] [INFO] 768 VU
...
Vuser 2:VU 2 : Assigning WID=1 based on VU count 768, Warehouses = 24 (1 out of 1)
Vuser 2:Processing 1000000000000 transactions with output suppressed...
...

Now that is equal to 4 * 192CPUs that my LDG has which means I might
need to match the same configuration as your LDG to mimic your exact
scenario.

768VU each processing 1000000000000 transactions sent to a 16vCPU
SUT instance seems like a highly overloaded (and unrealistic) scenario
but perhaps your LDG is also a similar 16vCPU instance which caps the
VU at 64?

Currently doing a trial run, staring at logs to see what I need to
adjust based on the errors. I'll adjust the LDG based on your comments
and try to reproduce the scenario over the weekend.

-- 
Thanks and Regards,
Prateek



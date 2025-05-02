Return-Path: <linux-tip-commits+bounces-5158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB1AA6B56
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CE3461E34
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 07:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0B267387;
	Fri,  2 May 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ntb7cd0U"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1062045B5;
	Fri,  2 May 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169759; cv=fail; b=ebXCGAnyeoJ1NkA/U/rTeLKA78ryfoO4C65q4NhQFs2rjUQea2KzfvmcVM8QiLCoGV7AomRvYB7DHRBold/znYylbuVG+rmW/a2O8bGH8l7bjDFB3AFZ9FNwSzm3jtKZ3KTmRikgm3clcXx3/wf2OrbTKp7r4NZwQErCvUOXNuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169759; c=relaxed/simple;
	bh=4Xkwlwp4+Yfgls7zQztDRtC0cDZ7A3lt5z4RyJ/CM24=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rznB4ShK9drrDWqFeVP0D3+U31l/z9lKm6TL1QEIcQgGbv3Kr7JefMP4tXuzlYAIG0cno3af2j9SvmbMxleZ+O4iw17N1lZwOklOB9ZyTXz7/lryRU+dW6F60HaG4Y+lkcjMwRKpdYpBYbBYsQZbrKGDtYDz/gSwW614f3/t8do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ntb7cd0U; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE9yD39kiSaftm4tSpe75Ns78q53sF5q+ixHezLiIbVvZ0I/2Re8FFgnZ3IMelgonPS0YxDtc7PdAn3hKTwdeRandl9TBCt7zux2Hmx49fG7MPkHeYJ6GXnYvp7aUh9rHgGLMvWUT3nkKD2qZ+aku6v1Z7yBbrMi0TBtDNJ2v19pGEVCjTZVTWZOJ6Q2VxSHTmqUPjlcscv4aTvQYbZhBbKz9T2iKj3daNFdjfJE5g8WyqSvwWsfa5cOvm8qh9C/1IE2ZaVgZXLiBJunxaWghqj3ngq2U8t7jG+5FAtpLKxl9jZRXV4srBYI+byNYq9ac55x58G5j6qMmVvFM8Wspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A941FMKc4jIlmPhxDi9BbEnL+m+baDA1tUuTO7z7qvY=;
 b=NVORBwypvrutGFZ9XU2+Mxo+4zA2Z6c8lIqAqCdYe+buIQ3wiKyLzarXnmxvjUrJsdjWlwzqAkjLfdtAjwAuBzLk+I3rZKFaHvSxzMVgNXc4ASxoUxXmvvgUQlJezGSaJiRO8hXzqMsXsZbEsUKp01FpmZNkbd4EC8WQTV3eRCI4+YoV+aeqZW2gOczSCWsEPivpd7dUHFj+MqHI2nrUDneiFnSYd5p9S+Jxm4NEYxqYE6ADMjsjXus19lMBR2XztDSdP85p9aKjv+kj4k24VgyZ0sGdOuzezJUp8ESLYkszc80Gewl43J8S3RADPfi1xGNUdhZH2oDHPTE115F9Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A941FMKc4jIlmPhxDi9BbEnL+m+baDA1tUuTO7z7qvY=;
 b=Ntb7cd0UNRq1Zm+ftQapESfG4z7SS2jmwEEw3mPw4yCQkylmphFtPZFBLAjpovywkK2kPe5XBYr7VV2w8yWK6AmHTPpdJgsp8scUnI2z+ePAUIzRfRKeW1PORMiHtJZhOBQ9b5yCyujxuQFEi4JOxmZdtCHmRk/0UiU+eLVXXOU=
Received: from BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34) by
 CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.19; Fri, 2 May 2025 07:09:13 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a02:80:cafe::44) by BYAPR01CA0021.outlook.office365.com
 (2603:10b6:a02:80::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Fri,
 2 May 2025 07:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Fri, 2 May 2025 07:09:12 +0000
Received: from [10.252.195.191] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 May
 2025 02:09:05 -0500
Message-ID: <52515bfa-4520-4eb3-80c9-eb1ee0e64ba8@amd.com>
Date: Fri, 2 May 2025 12:38:43 +0530
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EEVDF regression still exists
To: Peter Zijlstra <peterz@infradead.org>, Cristian Prundeanu
	<cpru@amazon.com>
CC: K Prateek Nayak <kprateek.nayak@amd.com>, Hazem Mohamed Abuelfotoh
	<abuehaze@amazon.com>, Ali Saidi <alisaidi@amazon.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, Geoff Blake <blakgeof@amazon.com>,
	Csaba Csoma <csabac@amazon.com>, Bjoern Doebel <doebel@amazon.com>, "Gautham
 Shenoy" <gautham.shenoy@amd.com>, Joseph Salisbury
	<joseph.salisbury@oracle.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-tip-commits@vger.kernel.org>, <x86@kernel.org>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250430100259.GK4439@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
In-Reply-To: <20250430100259.GK4439@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 79ec678d-f6f3-4a51-69b5-08dd89483e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS8zSkdGdDVlbmxoWkVLSGdyNjRtZ3IxWWd5bEVobjhoZ1NKNUVKNHYyNmdC?=
 =?utf-8?B?OEpicm5wdVJEaUJod3BuWjNwcFJkNklFczJDSzNoeTExcXpyK2FVSWF0MGJu?=
 =?utf-8?B?MlF5a2NFUTBmTkcxSWR4MEZOVDBTOU1NdUVRMThwdlA2bHIyRjNwOE1BV2ZR?=
 =?utf-8?B?emJUaUNsWlY1T3luRk5DTW8wSFlJSWw4MHdveDU5QnJmU0xJMlk0SXJ2Q0hM?=
 =?utf-8?B?MmovNHZXS3dNK2FPQ3RVZERFdWxXek9xOFA5OWo1T1VaciswRFcrRHhMK25W?=
 =?utf-8?B?TXI4YmVKbzU0REJaMC82RCtYOWFrTGdTR2gwVzhGUzY5UDZLWkNDbDRsa3NV?=
 =?utf-8?B?VnZTWHpEdTA4RldEZit6RlMzajJBdFRmMzJiQlBSYUZMbml5ZWlPcGdUR1FZ?=
 =?utf-8?B?dS91aU00c0FCOFVXaEM5d0RNaDE5YTBIU0kyRk1yMDR3dTJFNGxZZmVVdjFp?=
 =?utf-8?B?bWpENTdkMlhpbFZwR0FOaVozT0FVWVR6a0tnZzJFTlN4eXltYlNFVGdCTnhX?=
 =?utf-8?B?d0NveFcyRVVTTU1NS1NJUkVYSEFEVWovZG9odHBZMlo1anZWWDhiZXZ0aW1X?=
 =?utf-8?B?TzZXUmlKMkFzbnVZdGgyeWNrMzhKR2JBWG5LVjVady8yVzkzUnhsKzZtTjJB?=
 =?utf-8?B?UmdGZmlIZzgwUHRISGdDRW10Q1dHQktXUithVURvaDdxMGZWckxPSm9BUit5?=
 =?utf-8?B?Q2k5cVc4YkhSS3hBU1hTQTF4bTRjSHg5ZStQWFhiV09BS3hDQVhmRldtODlF?=
 =?utf-8?B?VjZsSzZmM2pqU1R6cWVVWnFoTkhDWiszNEl0M0lWSGtTS0ZFWVR1bEYvS0V5?=
 =?utf-8?B?cUFnTVZtSkVneE1TaTIxbWFkdmZyTmc0bk1ZQjg4MmpkRTNrMlYvZUo5OWZR?=
 =?utf-8?B?Z3BQaGFleFBTKzZiK0VXYXQzY3hucDc4NFZzdmpFQVFGaE5EVkM0OFdKWkFF?=
 =?utf-8?B?TUxkb3p5UitLMWw0MjFMSlJyWitzQkszUThjZ3NGeEtuWkVRMTVYcGFCTks1?=
 =?utf-8?B?cWk4UGhEM1QyM21iend0L2RmVkpPc1NkNEhhbU9YMklYNHNNL1czQUpqOWJI?=
 =?utf-8?B?V0NZVmpCSEhLSDZzQkxiU1VEUG5WanhRUFp4Ukk5VjlOdDY3ajNNVFc5RjFP?=
 =?utf-8?B?OGtIR1RIQ2xwZm1GejNHbk0zVE5yc013MlZBTUZxMGRDM0lWZmhnQ2pvNGt6?=
 =?utf-8?B?ekY3b2dTaWJGTGRGSytwYnJ1WWY3cHFUUUVFRW1GTGQvcnBubldQalUreWpV?=
 =?utf-8?B?RnpTTENxai9zbkxsWVJEU2N3eURMMHliM1BuUU5EbGtad21JcUljN0RTbjJj?=
 =?utf-8?B?c1ZzSENCRWlMSG5SaVJoU3hVMk5ITFhvOTJtek00WFd1Qzd1VGJPYXlQOW40?=
 =?utf-8?B?bzYyK3dlUnpmL3VPejhDTDZmaENNSUd4QWhQVERBdkhlaUhGbHhMak9XdnN2?=
 =?utf-8?B?Kzk5cWNiWXJwNHpvWms2L0JRaHhjNTRIM0hGZGJyWGNEdXpwc3V0SXJ5SlFM?=
 =?utf-8?B?Mkk5ZlNkWkFVdG9BSjJXRktKN0RwZUxiWGNwQjJKS1dmcFZVeXBYa2RtYUZY?=
 =?utf-8?B?RjBLc3VTSjJyMnN2RGlaNXN6eUFzRmNxS3dZa2UrWFcySkdDNG8ydmxiUTM0?=
 =?utf-8?B?MG9SM2pTbFAyd0NhY2tnVmZLYStkY21CSHBSQk1oMmJkeW9jTk82Z1BoQ1or?=
 =?utf-8?B?enpYVlNlSFA1YWszNVVVUkVBQTd1a21BbjdaR2M5aVlHWVFwMFpEcDJxejVz?=
 =?utf-8?B?NC9Pb1lPOXk2alBtMFpPdG44NzRoc0lpR2dTM3N6MFBWVWk1ZTJlVk9wMUZH?=
 =?utf-8?B?Z09IYW9zYTR2SW9BcVVXVHkrTEM4ekd3cDg3V2l3S3VFRFQwTHI2U2hCd2Ni?=
 =?utf-8?B?SE5aS3ppQ0dJWkRQSjZIczFRblJ3bk5LU0pzM25qZzNQaEZDblpscUg1VDdJ?=
 =?utf-8?B?VUcwK3BTZ2N3eFJLTFNHeHBHa01xajNNS1BkVGUxZVhrMXdiRHJ3d2dvUEpE?=
 =?utf-8?B?RWh2N0Z0aUhTelp1NmpsYjg5LzRSZFRsSzBYZ01zblBhOGIrYklCbkMySlRq?=
 =?utf-8?Q?4Uvh/t?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 07:09:12.9571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ec678d-f6f3-4a51-69b5-08dd89483e39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869

Hello Peter,

On 4/30/2025 3:32 PM, Peter Zijlstra wrote:
> On Tue, Apr 29, 2025 at 04:38:17PM -0500, Cristian Prundeanu wrote:
> 
>> [1] https://github.com/aws/repro-collection/blob/main/repros/repro-mysql-EEVDF-regression/results/20250428/README.md
> 
> That 'perf sched stats diff' output is completely broken -- probably
> trying to diff two different schedstat versions isn't working.
> 

Yeah. Will add a check to bail out the diff command if schedstat versions
are not identical.

> Anyway, looking at the two individual reports side by side:
> 
>   - schedule() left the processor idle             -- is up
> 
> vs.
> 
>   - pull_task() count on cpu newly idle            -- is down
>   - load_balance() success count on cpu newly idle -- is down
> 
> Which seem related and would suggest we look at newidle balance. One of
> the things we've seen before is that newidle was affected by the shorter
> slice of EEVDF. But it is also quite possible something changed in the
> load-balancer here.
> 
> Also of note is that .15 seems to have a lower number of 'ttwu() was
> called to wake up on the local cpu' -- which I'm not quite sure how to
> rhyme with the previous observation. The newidle thing seems to suggest
> not enough migrations, while this would suggest too many migrations.
> 
> 
--
Thanks and Regards,
Swapnil


Return-Path: <linux-tip-commits+bounces-6006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3E0AFAA2B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 05:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F0917428D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 03:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8C1BD9F0;
	Mon,  7 Jul 2025 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iUss6x3t"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D5F510;
	Mon,  7 Jul 2025 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751858775; cv=fail; b=ppB1VKGOmEfBKtRKxzj7EgLVAmGTqOes33eQqxJuieftwXsMa0PAxKLUtsT7CR6C1slx1xf0v00TJA1Hw/vH9CA8og+VMOLG4LvZMBNQ5snSKPVyujcvC9aIcU+D+aceGmlUVCYiN3DAdXFSvNPAemhqxOKOEKD/sJOOYBuTC8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751858775; c=relaxed/simple;
	bh=VjVpO7HlMl2GaC276Fm4HtpTEuC0cR02nez8YXEpMAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sd7MwU4NH/HWxJIx2KAQdkUfBpJCh7ZZbv48sUUF3g0/9sx7xx31r4X7zv5pCVG1nJFyCOjhVjFl56llHIggycSrX4Rx5Otc4hIMCvXFjC9SpR/R92wzfdlmKI9xgNHwDKHGltRQ8/X9gft2h4NG6JjjQx/xheDrDqNtnnyKcCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iUss6x3t; arc=fail smtp.client-ip=40.107.236.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNx3FS+KeA+ThLpasgCq9zlz2hn+V+deVGejJfOv7neSjxliiCdtuWr3KU0o7thujcJ4FTSF2j2QlZnosYN8ACDadinUiNsczFcEBhoa8vyoXd39OyPNy/O6lxjqQLqGLQocPlKh9g8z3MWU2fIrPHPaSmeQsqoLLbGJBoKvq8aFuVBauiT6oWIIybEd8UZ4ssV0TcKWnqA/arF/4v7AH8DXLZGzx8N0awgqB67yJW7dNCnf+K3oJClF1+x4d+LxvHH1G8cNgbdlAwSOsP1SKFqRgMBWaRUESCE8upzTCuhTHP9KItLMTPmPU1XdYyQkmc5LbEmC+Kqo6ZRYmBiaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6xTwFwKqzPFanLjIh7jA7qmT1C07RsK5m1FhxGhUyo=;
 b=H9vzwg1hWQCBUfxv+9e4ZMd6TdJ5ugctr8eQaRuDh3dY8RQq8zasenO7EsAWrQp5Mf34YMHvofsPvbf/qVh/HYQW/jwZKYWzv9Iegm1tZ7oLh+x3IWsgGwaMgrheEYIYL5X9P+K3BVjzNaZda8VWRkyEQuHv1WZw2vgrkAdm4Kne0Pd0OnJHsuHoJFs4Io1jOqLNPZ1aNhsx0AC5WjJ8k5UiqQC5OB6kro1hTUPpLUq9xYGl+0PlBHHcZ7YfO9BiMgnf71fUhUs/QrnSOMgEiwg+zq5K51jggWlgenBCvwIR3h17E5WjL5B0KaysMwEa5iqopOX9fcJMuKxu3RANKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6xTwFwKqzPFanLjIh7jA7qmT1C07RsK5m1FhxGhUyo=;
 b=iUss6x3tGmK69A4Bea3cwan/Xc0xkd5sQT7AZNqwelpS+zOg2dpeNrCNGLxFHHUDi+DoJjEx22OL5NUGCCS5UIaUV7v12qT+SwWQatKR3XIzhb0VqsQmZQb+IpDtzWexi8+TOHOkATCe3+gyMunQC/AmZuTPGfrTzdqnjcz6mbM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 03:26:11 +0000
Received: from CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42]) by CH3PR12MB8658.namprd12.prod.outlook.com
 ([fe80::d5cc:cc84:5e00:2f42%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 03:26:11 +0000
Message-ID: <5990b258-2963-4a0a-95f3-db02676d60ea@amd.com>
Date: Mon, 7 Jul 2025 08:56:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: sched/urgent] sched/fair: Use sched_domain_span() for
 topology_span_sane()
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, Valentin Schneider <vschneid@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org
References: <20250630061059.1547-1-kprateek.nayak@amd.com>
 <175162039637.406.8610358723761872462.tip-bot2@tip-bot2>
 <20250704102103.GAaGerDxWX7VhePA3j@fat_crate.local>
 <c3e97fe5-f058-4958-8660-a661f6a662a3@amd.com>
 <20250704123307.GCaGfKAzoceu9siXCN@fat_crate.local>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250704123307.GCaGfKAzoceu9siXCN@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To CH3PR12MB8658.namprd12.prod.outlook.com
 (2603:10b6:610:175::8)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8658:EE_|DM6PR12MB4481:EE_
X-MS-Office365-Filtering-Correlation-Id: 811d0da2-3b59-46b5-fe03-08ddbd060516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUJiRXk3MDlycUhRemNGNy9TMTJOaWRDcFFTL1VpM3hJOUxKcGNzd3V5R3pv?=
 =?utf-8?B?SkxHZ05xNFo5OTgxemUwSmpnQ096ZnRoekRuOWNpaHlvdjR2MVlBREhkSytw?=
 =?utf-8?B?N1ljSHBmeWVBZU0yQXN4eU1IMW5DTU5QTW5JWFd6K1NhbVQ5QmVtMGY4Njls?=
 =?utf-8?B?Z09UZ3JqcjlsY2tiQ21Xc1U3enQ1TkZUL3JubzBZNWFtTWw2VEJubWRYbFli?=
 =?utf-8?B?WWpDb2hPZXNoTWJPR3hENGcwWkhIenlmVmdlSTVlUSszRTdwUWxhQmhIQXk3?=
 =?utf-8?B?TlNXM0FsVmcvNXg1Q3NuYTB6SlFIS1plQ0F0N3FMblhwc3RUVGRDcHpUL2ty?=
 =?utf-8?B?Znlyd256algyd3VHM0dqaTJ3blYzSElJMVdxTzNUcDBrRnVCREtoTm1tcUVw?=
 =?utf-8?B?dHRFc1dLVzRLTzhGV0tLRUVxUFdMZnhNenVOaklSb2NrZnlBZFZEaHJZM2tQ?=
 =?utf-8?B?MXBVblE0SFVHVk1KRUJYYmMwTWJpTVhPZ3dFNjA0QVNQZmtSbE1nMFNlN0Qv?=
 =?utf-8?B?SnJGVUNUY0cza0FCMmtWWE5ZeDNNZWNTUUR4ZHlFYlg5MVMvZVdNNzl2cGtu?=
 =?utf-8?B?ZVlQZU5qdDBJRGhGOW1JY1FHTTBVV2sycVVxcWF0R2p6TE44eHo4V3Z6c0ZD?=
 =?utf-8?B?Q1d2bnFJdHZvc09hcEh1OHlYMVYzYzBDV2xtNzdYNzQrZVMzRm16eU85amhJ?=
 =?utf-8?B?U1QyZzkvNzZyVE8xMTk4Q3NOUVNaWjlEc3ZobkNpYjU0Z2dYaStJVDJuRjdZ?=
 =?utf-8?B?UFdIaWJBM3crdTd4S2wwQjFYcUwvMkF4WUJPL0IxVG15bzJXNUpodk9iS1RB?=
 =?utf-8?B?Yk9yNW9acFpMWkdHdUVqQTNOSUgyR0Q1SHVqZzBlUGFSWm9GdXZINFdjb0pr?=
 =?utf-8?B?dG9pSllweXhiUnBIYkcydHpRWVJaWm5qTGN3TU1mbXpzTWt6WFpEa1ZEWXc4?=
 =?utf-8?B?WkdWWFFUZlVzU2E3TU05eitGN2NrQkFROFpzb1JzVHRmQ0Qrei9zQUxrT2JH?=
 =?utf-8?B?SGdCZnJQM1Y2ZFRvZkpsMEFqNmo5L3BFQjFUd3IrNXMzcTVXL283Sm1CU1Nh?=
 =?utf-8?B?c3VCay9lR05wOHBnd2owd0NSQlJrbERxTU5IVDlmV09qRzRPM2xkMmFJK1VM?=
 =?utf-8?B?NFR0b3NySVUzK0QvbDJZR3BGYzlUUEt3Si9mTjVZbjFUalNYYUF0d3B1TSsy?=
 =?utf-8?B?MjMwV29jRDJzVEgzU21VbmZlTmxJaE9zTUlhV2JyWjg0aUFoZ0I2eG9tN1Fh?=
 =?utf-8?B?MG9yVmNScDRNR1VyaTJWQTdUTGRkeGdtZjBMNGI0QVpQRytwUWdlWXRzVThB?=
 =?utf-8?B?aFBQcnNLZnJvUS81cmQvMHZDNXdRR0xhaFI1dXQyTHRGOE4yN0VtcW8vZ0hI?=
 =?utf-8?B?RUJpaVRYdHB1dXNtSmVQU21lZkYwT05UNUhFeDAwSEZJaEoxZHBBWHF3LzJL?=
 =?utf-8?B?d1RnK3I5WENodXU0cVZsRjVTQlYvOCtQMHlLellhNWx1UXZ5TS9zNk05LzVJ?=
 =?utf-8?B?dUxPQS9CS2hmSXlxNEVxTkNHZjZYTmp3U2ZFMm5zc0UyS0c3YTBlbTZHRXh3?=
 =?utf-8?B?K3JQMkw2dmlJK1c2Wi9GRmpkMExod3MxN01JMXdFcjJsblQ5NDltV3d5QUl4?=
 =?utf-8?B?WkxZdWhWN25OTlMvaUlrbXhCR2dzbGk4UnJwTFQ5WmNJQlkzMWtpd1ZCVnZq?=
 =?utf-8?B?dzJZM0hKdTAzaUVoZkRHaE9PVUhScjdZTXBnTERYaWZ3WEE3TmVoWnErSzRP?=
 =?utf-8?B?dHViSjVwQWF0VHErTWNPQWhLN001UTJEQUh3TVRlK3FhT0xGV1hUemtnTGZH?=
 =?utf-8?B?eVB1TC8zTlQydUp6NXR3cXptYWhreWQ1dTFYVWloa2dHR3NSRncvQ2pLcjZX?=
 =?utf-8?B?RFZzeHpkZGlxQUFaMDNCS0R2dkFXYXV2WGpkaCtrOUJ5TzFaYnZCYlJ5UUg3?=
 =?utf-8?Q?OQc1X+Dz1x4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8658.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZOZ2cxWDR5NWRyMmUwbVY5NkNFc3B1Vm9ibTBJUXplNzgxOHZMaVpSRUZC?=
 =?utf-8?B?UHE5OGJuYVlxMTFRNmt4OUR1aS9ONFRKdzluc3FpdU9ZZ0tZR3E2OVA4Rjlz?=
 =?utf-8?B?RlppZEJsVzJJWmQ2dWc1OU93RUpORHlxZnVuOVB2Mmo4bXZyOVBoMXNmczgz?=
 =?utf-8?B?S1pCdkRGVnJWYWoxTXB2N2l5N296Sk9STmRVUGJTWS82a2F5RFdOUVJKZUxJ?=
 =?utf-8?B?NHRnRXh4TG15bTZOcWpPc1R3QzNCbGFRUUpscjVxeTgvNDZVNzdLVDFTbCsx?=
 =?utf-8?B?N0RDekhZZmQyblVkOURHL0xwSEJEckpEa0N0VlJSRXo3T2FsbzZ4V3JoWkIr?=
 =?utf-8?B?WWsvVDNmeDV6ZXpYNFlablFvbE45TSsxdVgzeWdHM0JmaFRISjF6RTA3cXE0?=
 =?utf-8?B?czdvaUIxdDhDL29QN1NWdjVxaml5ZUQzSkQ2UlMybWcxdk1GY0dnd2ZKbFFH?=
 =?utf-8?B?ME1CS2tROTgwY00zWTdzSWJQTE5pbGpteVFRQnVhRGxUNEdQZUJhUTduZjZN?=
 =?utf-8?B?aGZNNHY0Mm5zRFZQdngyMXlDd2hDdjFGVi9lNkVxN2o1UGh0UUtsT2J2N2tq?=
 =?utf-8?B?ZWVwQjZYSjZWeDFjZXI3dTFaOVVqUHl4UVEvSGxCUTFzOWZmbTlYbkt0SlMw?=
 =?utf-8?B?U1VCU1B0MXhUZ2o2LzVlWE1KR0FkbFUyUWFEWUtiN2tlWFBGTVBtWTFMSDg4?=
 =?utf-8?B?NHg0T1hXcGw0ZElvOWtLcHhPQmNzYXdPSWFxSVZ5NDRLcWZNTmpIbmdPcjJ6?=
 =?utf-8?B?Q0xUYTJUV1dGV1AzOWkwYVIvSE5aaHI3aitMMlZXc09MbThYN1ZnaW1PWXBj?=
 =?utf-8?B?L3ZQMHlValdGTFBkZWxoQStZVnVCT0ZJSjRZajI0b0ZjRXUyTCtKMDMvbHpK?=
 =?utf-8?B?QVJrbEdkdzVacEw3dHFHQXA3bzV6L21iOUNrT3ZGTmc0QURBMmNSNERkMlEv?=
 =?utf-8?B?T25qd09EeG9pVmZqL0tSMDUxbW1LY083MS95ZWk1dzJXaWE0NkpBaC9TSFgr?=
 =?utf-8?B?WTNzVDF4czRYN1ZZTTRMMmRQNGtXaHliNWd5TEEvc0k3Y2hON3UxUE5aTEFI?=
 =?utf-8?B?eGlJS2FzSTRwQ3R1amxORnk2dWZnOEZMczNBQ2RDRythWmUwdzBsOXRBNTNi?=
 =?utf-8?B?R1pvR3ZaZGtFc1FiMG9iRWJ6RlpQOU90aTRDZzZXWUZrOWZUZmlkVkt6d3Bm?=
 =?utf-8?B?c2ZPcVJ3Z01Sa2FnM0l3emg5dUhvT2hJK3JDYmYwdU9TblpyYWdQNG03emRD?=
 =?utf-8?B?bjJMNjZTSmIwVWI1NFkxeEM2aHg0YjhTalUrb0tJL0NWTTlMdU92R3RSTlZG?=
 =?utf-8?B?OE5mUHkxZktFWGhRUWNIZkN5YVNFSktYcHRKanhJVDYyTXovcCtMNkU1aTdN?=
 =?utf-8?B?U1dyTjMvOHFoeFVRbWdxZWJwaTBjR05XbVJIQjc1NFNiRnpXUS9vR0pBaVpE?=
 =?utf-8?B?YzZoRFllZTRCcGw0SU9rbHcxSDFSYlpTUi9KSmQvYTNhZUIyVnR1QUlJSUxL?=
 =?utf-8?B?aGpwSmJzcFd6RzhXSjdTRXlpa1lyaXFMVkJJRmJQVlc3Y3lQcG5GWDVVSHR2?=
 =?utf-8?B?L3RBbzE3QzlFMWMyWFBISi8rQlhGcjZUSUVldExNcVh0VDRrNE9vcmRmRStm?=
 =?utf-8?B?T0krTEZ2a3R1dXdBTUFZT25RWElLdUE1eXhseXNKYWhZZjJKSW9HWjJyQ05r?=
 =?utf-8?B?NzZsWW5kazZHT2hnRHpXQnR1S0FuWEFwcGJKNnIvWDhIUEFMcUc5RWZmQ0M4?=
 =?utf-8?B?QVF0REI0ZEN3OVpvSDJweGgySG01emEvd2k2OVUrc1kyWHZsV1Uwa1lJSzlt?=
 =?utf-8?B?SUtUeWNocUFOQXo1cDdrK2RreWVhRllwdTh4T2FIUHFNK1MxOVRncTVzK2NP?=
 =?utf-8?B?dkFPa0pHSVN1cndTVGdGZUV1WTRnRS8xbmdDR3RIWGtGZitCN2xzSWhlNEFU?=
 =?utf-8?B?ZjRBY2tSdktKaTV2d2N3dnJzRnRrclNNcEd0bUZ0UVp0OERidVg3RnlnN3BL?=
 =?utf-8?B?WUFURHNFcWNKam9paWgwS0hXS3FrbUFhUmNWYlB0QnVvanR0S3oyS1V0Zms3?=
 =?utf-8?B?aVJZci9Wb3pmT1hxMGdEUkdKTkZkZE1wVjc1dWFJamkvQlNIeUNpY20vVTV0?=
 =?utf-8?Q?Zx28tFNq85nzwsg/idT9//CP4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d0da2-3b59-46b5-fe03-08ddbd060516
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8658.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 03:26:11.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aU6WReufog7HKMIcjKIZIX/spSDdL6xVmW08D/wtQ65JIt+HvgQ8N0GKEZ0dsjW84lF0YOP3vWV5QC9eM/X/zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481

Hello Boris,

On 7/4/2025 6:03 PM, Borislav Petkov wrote:
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 0e46068acb0a..cce540fe36c6 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2423,6 +2423,14 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
>>   			struct cpumask *sd_span = sched_domain_span(sd);
>>   			int id;
>> +			/*
>> +			 * If the child already covers the cpumap, sd
>> +			 * remains un-initialized. Use sd->private to
>> +			 * detect uninitialized domains.
>> +			 */
>> +			if (!sd->private)
>> +				continue;
>> +
>>   			/* lowest bit set in this mask is used as a unique id */
>>   			id = cpumask_first(sd_span);
>> ---
> 
> Yeah, when you send a hunk I should apply, no matter how easy it is, pls send
> it from a mail client which doesn't mangle the diff otherwise I get:
> 
> $ test-apply.sh -n /tmp/diff
> checking file kernel/sched/topology.c
> Hunk #1 FAILED at 2423.
> 1 out of 1 hunk FAILED
> 
> Or you can attach it.
> 
> I've done it by hand now.

Thank you for the testing and sorry about the malformed diff! I'll
double (and triple) check next time before sending. Thanks a ton for
applying it manually.

-- 
Thanks and Regards,
Prateek



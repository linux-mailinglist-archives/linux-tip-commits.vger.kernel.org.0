Return-Path: <linux-tip-commits+bounces-7515-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9FDC8083B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3296A4E3C1B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 12:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CD2FFFAC;
	Mon, 24 Nov 2025 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iRDaR6zz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FusmqfrT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA82DF709;
	Mon, 24 Nov 2025 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763988075; cv=fail; b=EjAe5FvyyNN56gc0qsDo6NAgidLoSutwMn+fLoNzGrjzghNFW2dgahIr+Bm0kDJ1DUa1/3fl85bnB7KoF8sbiSi1zMg4/zn+gB39wgmBPU+M+ctqtEnCPLA4eEFkOOytCaHE1pfVvQr9iNHyKVPBT7FB7MX5Yw0qrhlxWsAXJTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763988075; c=relaxed/simple;
	bh=Hw9qp/5G8f6EJVcGHwqXKWtbPy0H7+O6jEesFzNDE5E=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ETfn+ZSU2RiSj5l26JNHCkp8RGRs4CPXoGVZ3cx/GjdE2XWUYgHFfgVyBEVPiBc+mJI6H4pkL2P7QoQ6U0oIN8NE4lCKZh+UNdyIMbKm4vQiZHgFIxPbEH5ylQ0cvkhK36Vpptgs3CLhmzRJzLa4/cZ5gkhqCLKHy+AplqKHZok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iRDaR6zz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FusmqfrT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVU6m1055287;
	Mon, 24 Nov 2025 12:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jcpb3ieC1fc8YgZX7vn0o38/hWlYNseaOhbSDQF0Cgg=; b=
	iRDaR6zzIFdbOqjzKjhPE4PVj7TYPADr+x8zog5nxxYW682BRmVZ3skqpYA4iW2H
	eHwaa5jBjbqSDmob/gLrZKD4AIgV4TyE9HQmvXbcKkcNDpnNqdb9P/HIcStfbBjW
	NHdnkK33UmrRXp+Llc5E2rM1fNsIZRxzGOK6+vLYIag+vJADGYO1e6GA4pm6hJQw
	08UaFZCyBftktWYwnCy6D7uRbeK71jjf+gSnJryY+w/j/G9mhoPzNKxXQgUyFpX9
	N9N0n5EZIQ0KqFBD11V5Q2RX2DGdlxkqnbEf6ANpL57LoXkNEqqNhRpmhXptyZ5v
	Wx50oXBj3ETC/ug+8E7SVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8d2sxc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:40:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOBb96u032418;
	Mon, 24 Nov 2025 12:40:53 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m82fr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 12:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muKO/AOAMD5Jf3hxjTaWEIbs+sEvUieecbe9iONql1JqlYNIUBFMgJ8S+QgA6rWNLXedc4zg+mtcSbk/W4S3w2e2p9T2OcH1HfPU6nysQvp7iOHJuTTtW01eOXzljuzdZDgNQmOZfDI7isJ4yWoU+QcSRTi2W2slqRYkQD/U34McZ2OtRIu6G3jr0NLcHIXEvfdILO3pXLICIl8FK556bjFAtqu77NXURQZtR0ZtT5ECqwsD17IC0psLIa3rchWAEH0eDlizS+7av26LkcVtM6q1oTQD0wPkSmuxJ8i7znjL7tw43mH5nQkaLWBh8CyCVPwM/1K+zORa7v5imrkcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcpb3ieC1fc8YgZX7vn0o38/hWlYNseaOhbSDQF0Cgg=;
 b=gwV/spIREcxMdOhQGbGMrTynO2ezIN5gjSqeb6BwjgqTYqJozcOdBJ/1OJKZCsIkmw9zFTDgheZXR4P0lbI0FUMlU8vRRb6bjfqAO0M0PPyVAS16FnZ4vB8opAc1HP/XFegbJ5rp85w9CRtYjIVzqUqZmNBWKAgOpErSk3MJfUaHHZTqaX31ZNYtbOVhv78lmlAMOisX8RRHNeOl2eGppHI5BJZDIA4CBRnNtYAFTMdqvU4pzEpkWt3cJmnoW5BuQJAEGr8lWRPPtgimDA9lg2ZVBiMh69fBr2GY2j+dfYCbKsmBAHB8aPNKY8th6MozemFP5NaDyEok2eItnrWieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcpb3ieC1fc8YgZX7vn0o38/hWlYNseaOhbSDQF0Cgg=;
 b=FusmqfrTRnQ1F/nTQvvF4iVyM07E0nDoDhiNT7A8i36oQ+TNcDAQKjYs7Q9QQ0BYmOY8OaK4iRDH/WhwKQV5+CU30rXIQIMC7r9b4YfhURnf/+uQpq5D9o8/IuBnbrGb9hGf3W7QrdEEKwVLZOwL10Qq1xCizZaLoPMjYUwdc/c=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by DS4PPF92DC283F3.namprd10.prod.outlook.com (2603:10b6:f:fc00::d32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 12:40:50 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 12:40:50 +0000
Message-ID: <a8b6e603-e3c0-4bc3-b36b-29771d30183b@oracle.com>
Date: Mon, 24 Nov 2025 13:40:47 +0100
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Function to get the name of a CPU
 feature
To: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
References: <20251121095340.464045-27-alexandre.chartre@oracle.com>
 <176398104154.498.14035591969424868341.tip-bot2@tip-bot2>
 <20251124115942.GO4067720@noisy.programming.kicks-ass.net>
 <20251124122639.GBaSRO_-G9dUtVHMaY@fat_crate.local>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20251124122639.GBaSRO_-G9dUtVHMaY@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0013.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:21::18) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|DS4PPF92DC283F3:EE_
X-MS-Office365-Filtering-Correlation-Id: d064962e-aa17-47e8-35e7-08de2b56b2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TU9IMnNCQUtrQ2NLOFJpYlFYUE9VL3ZERzJrMFpxQjM5b3RTd2dqQXFPNFpM?=
 =?utf-8?B?dThOQk52RnVMQ1dhUE9EMG10ZjgwcEpkYWhjS0szSlYzV09jZWFEZWtNcmVV?=
 =?utf-8?B?NklpYlNoNWhKVVJGQnlTcDhUdmNJbFd6anI0NjVnWUxjbTlvbUtzbnVHOWk1?=
 =?utf-8?B?dWNPMk1vZ1FKcGkzNVh6TU5HT21ldVJMS0hPUVpsK1RJa3RhSUxkK1RmSW1v?=
 =?utf-8?B?TjUrZWdDZEdseW1JUEVFMXZLTEdRYW42VVhhdFhlSERBQUd5akhsbElvSDJ3?=
 =?utf-8?B?OWJoWHFtZnV6U1dZb2pWRElxdXJVY1hGaFQ5WXY0Y1VDdU5IZkFWVk1Vd3ZX?=
 =?utf-8?B?OXlOVkRhdk5YWnIrU2NVaGs2KzYwYnZZYUE1MTJDZi9jRnJKRkc4dWtFQTVV?=
 =?utf-8?B?ZU1oZ0I4d3Y4VzJDUTM2bGpMc0xtQmdxamsydjBpYmNJQWVTMWU1MzB3WXZS?=
 =?utf-8?B?SjJRblpGR2xuOHpTUjlzMTVlMkc4ck5XcmcrV255V1JEY2tFSEpqZjg4dkhO?=
 =?utf-8?B?d2s4Z0xKL1AybWowQmp2cTBCajREdXdpQjdndkRiY3Z5WmNEdXRIUjJrRFZK?=
 =?utf-8?B?Z0t4VGpQTkNBT2tHT1RkeEI1V1REQWdWN1lrY2QwbkFJclRteXpMMXdvZTVE?=
 =?utf-8?B?N3A1c091SHc1SVpBdElnUzQ2OUJsdTduYmRRMDNZMHQ2eDhmZDRWSVJkL1lX?=
 =?utf-8?B?SFhaWUErbk1CZS9meUVEUGtEYmNzblVGNks1Tmw2K0RIaU9aMWFjMXlYaW5T?=
 =?utf-8?B?UW1SZ0FsZm9KV0pqLzR3QlQweVNqV3J3L3dTMHluWWo0UTd0djFBTVptaW52?=
 =?utf-8?B?WGg2c0hrWHVJUE5PVkZVUlc1eDJ4MEpKN2VvNG9NNld0R0NuSDdvTzZzRWFE?=
 =?utf-8?B?RGhVdktUVGVoVXgvTVBFcUhPc3ZRRmxyb3QzWndhYXVUc3pGRHM3QW84T2cx?=
 =?utf-8?B?MEV2RCt1c2REUVpNcWNLQmtsL3kxbndnQko2ZFdIVDNtVWRIdFl4anlTeVBl?=
 =?utf-8?B?K0VBMlhkVXNVQ0U3djhvWjMwQW1yek9ZWVgrcWh5ODBTeVI1YjI3MW56TExl?=
 =?utf-8?B?NHh2M0ZDeS9XWFIrckRBWWNOOUVlM2tDL280aEFQcElKeThVMjlvNmFoNUxr?=
 =?utf-8?B?YmhPMVVqQXByempBUC8za3hvc2krUEF5b25raDRWKytPdkwxUjVxdW96KzBo?=
 =?utf-8?B?UUhKSDNGTENsN3FncUpibEsyTnppTHliMUx5RGRpN08vMjY0U0FVVFdqVDFY?=
 =?utf-8?B?czBLM2ZyR3ZkMTBxRGtCcWJhWSsxUThvYjZBLzNaR2pSRUFyWDJseXpZSEZa?=
 =?utf-8?B?NStaNUtOczRBOFkrRWsxU3A4cWl4OXM4ejEvaGhDa2lhUkZoYWxxQ0M2MXJO?=
 =?utf-8?B?Vm1ndnpCM1NRU01oY2RSdnJSZ0s0eXBsK3JTbFhsYlhURmlZVFE3SXdyV1Z1?=
 =?utf-8?B?Wk5oSGpCdW9oVzF2MmZDT1RCbVhBanNvOGU0V2dTbDFYbEovR0ZER1BFSExV?=
 =?utf-8?B?RFlUb2ZEMlZDTmRVWlJ4VWZ4TFVVWWNCbXZycTQ0dmdhVmg4QzJyb2VsY2dK?=
 =?utf-8?B?TzNVRHphOUhFWnZYSm1KaVdqdzh4MEhnY3gzN1JDTENUekduVlorRXRQU3FE?=
 =?utf-8?B?U25xMkt1K0VUNWhCYzJXczlibkxVQ3o2UkIxK3h4WFZHaEVGOFFmckRhMWNQ?=
 =?utf-8?B?Y3I3UmFOTTJjOVRRUVp2bVp4Y3FzZG0wRVd0RFNCUE4xaDJqRmp1K0IzWUFN?=
 =?utf-8?B?WXNVRExjUUNCb0pVaXEzc0p1WEp0Mit4Vk9CWlRqVTlQWlBEdDg1L0VtemJv?=
 =?utf-8?B?Z0pHSWh0M1lyRGtMekwzU09HekFIdTFaT0J1MCtGenN2T0pGOVlGMWE0b3R3?=
 =?utf-8?B?S3BiOUR2YmtWM2hNTzBGQjJ6T0tGT3F1aFIzWHlSektmbjZBWjhVajZteDdo?=
 =?utf-8?B?MEVrczN0TGw0eFZuQUlIeDR0dzA0SVpSUloyQ3RuMkEwL1B3RWtxSTk2OFVk?=
 =?utf-8?B?eTZkV1RWOS93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHovd09kaHdQVzMwQ0ZjQy9aVE5ObTV1eGhkZTlRR1M5TlZWWmVOVmxjMkNM?=
 =?utf-8?B?MGdQdk8zcGFpcUlLQUJwb09kT3ZNM0pxMFRqaTc5TjIvN1llMDgyN1RiS2dt?=
 =?utf-8?B?aUs4VEl1bW41Yk9vTmx5UVNBSWNVWURpUTNxT3FsWlNQNnJvQW4rWjJKRVR5?=
 =?utf-8?B?Zzc5VjU2K2RTdHF0ZHZXNEczNk9rcDRNa2tQeW03TTVRVWNCM3IrMy8wWlp5?=
 =?utf-8?B?N2hPb1ZnSFJER3pUZFBlTHM2dVZuSVJFUk5qaUU4TlRJMXkxbmk5aDZWTzVp?=
 =?utf-8?B?bStEbjB3bGs0MkN1ams2Y2xhUVAySlJmT0FScWRtNitTaWFCRGtnQVVaNjdO?=
 =?utf-8?B?eFpVUjBnSitmVDVrRlhmWThsSVlQRldOdnlPazhlTFloOVlCdUJBMWxmMDVB?=
 =?utf-8?B?YkVnOGwrVnF3dFZvRmV3eXJMNEpKTG5QeC9qWWJmNG9BU3hEWkNpSDgrWEo5?=
 =?utf-8?B?MHdtUFl0UmE1cWNpa3pxVFRDcXh3OGVqeFJyWTBNTDBzdmpQaHJ4bFQvc1hT?=
 =?utf-8?B?M3NyVjZ3dGN5NmQvRm9oSmpydVlqWG9WNDdVQUZ2UHJRNUdLRFhxUlZjRXBX?=
 =?utf-8?B?VXFQUFltQjVBZmEwYVZ2Zk5hYU55MGlObnZ3a2JDRnF0MlFxYkxSMzZZY2Fj?=
 =?utf-8?B?RWV2eEtPMXZ2MlNrbFJlWUd3TzkvQ1JQVmt3cFJYRUZ6M2FJN09yMXp6b0E2?=
 =?utf-8?B?L2U2cCtsS01hZUlIUWhoek0rM3NRbVozT2tld24zcTBUQ3VFM2ZzalhnY1J6?=
 =?utf-8?B?ZGNWRTRrR21YYkR1M3JTZU4zbW1XNGdOMWZLZW53bFVSM0RIRjczUFR0RDkr?=
 =?utf-8?B?Mlg4WmVZK1dKZDBwTUhVSjN4OXc5a0xnd0ptSFhFZW56eTczczZnc0tuTmVH?=
 =?utf-8?B?SWxjMjNmSUNOZ01PUUhiNkV3K1lZSE0rMnRVeUIxNk85RElIUGQycWxOODNs?=
 =?utf-8?B?ems5TFdJM1pnaUxVZHVyazVDbmNjSDdUZDRCYm5wOUdSSzJaR3hWSkhBazJK?=
 =?utf-8?B?YXJ4RjRzOEZ4TkE4R1lQSW03VGlFSzR3OEZMS1dqOFdmRkpHRUZZTnA3dCt3?=
 =?utf-8?B?SzFRbU04V3ovTVo2N2MyR1h1eHhJT1JaUXBBa0RESWdpbnZENlNZOHRmbnB4?=
 =?utf-8?B?RXNtb2RuTVRqRlhjdko2UDhzTGQ4amlub1NCWVhDeHZCWXI1RFFvQm5CdGhy?=
 =?utf-8?B?UHcxQXhvY3d2Mks2clhTYk0yS24yV2sxMERpYlpPZjlwZXQ5TytKbDk5SWFP?=
 =?utf-8?B?RjQzdi84ODFubXE2U1NzUk9HWXRiR2xScUtxV3JOL1kreVJ5OU5jc0cwQ2o4?=
 =?utf-8?B?T0JkTUtzc3N1aW5OVkNkdnVpWU8xaVpvbjNzdndVR0puaC80NW1QVVJjRDVY?=
 =?utf-8?B?Uzk3bDZOQUllVXBUK3hRb20zSkcwMXh0Q0J1bmlZYjdqQ0xRLzZFZHdiWE5O?=
 =?utf-8?B?bEUrckJYN1VHcUY4cStIWEVEd2d2bE4ybmhpd0QyS2tCQjZFR2Z1TWQrVUpu?=
 =?utf-8?B?a0d5eis2SGprZXN0cjVSMFFud0tqUFhWZWRUanNIOUVEZFRPVC95eElCU0NM?=
 =?utf-8?B?ZmJ2QnRpbzN0djI1RmxudGNTclZLOGlsZk8rakFUZE1DU1NoUm5IQnhoNTZF?=
 =?utf-8?B?TmY1UEVJSXRUK1EyUDBLWXBJeVNJUkREZFVLdU1YY3JUajJKNXQzVS9PRXJ5?=
 =?utf-8?B?eGJRcDNFUEcyRDQ0S3dvQUVKQVZzVk5YWWhyWHNIbXFTai8xZDB3ME1nRXE3?=
 =?utf-8?B?RUk2NmxYOGZsUkltazNvQXQxVnJpL3lYaFVqNVJIeVB3eko0OUxJSjFnZjZT?=
 =?utf-8?B?WmFKR0RQcDdYUzluUE1hVlBSZ3V2akVQekFtUVVPeUQrTEFaV3pIRHJKSk5Q?=
 =?utf-8?B?alNWdlV2NUZwYVo4b0dSdmNXekVBYndGWUxPajZGTnBTRnNBLzNsc201VEEx?=
 =?utf-8?B?VTk5dTJtRDc0Q0IrZWowckRud0dOY1BPaTFtMC82WUorRm1HRWYzUCtGd2pz?=
 =?utf-8?B?OVRTQXNKbVVrcElSNFRuTkFHNjMxUGFwOU9FOEVBL0s3ZVhBMHQ1TUYwMmdY?=
 =?utf-8?B?Vnh1ZUtnRWhuZlp3TWsrNDAzS0VidS9rdHNSbWtmeURPOGpid0U3UVFkblh2?=
 =?utf-8?B?RTZ6NnlCZ0s3Um5mczNJc09GVGJKRmJuVFVQU3Uyak1QQUdLcVJ3WVl2T0RR?=
 =?utf-8?B?bENFaVFOaW96cmhnbjUwdXEvQ2lrUHQzQTczY3ZoS0s0VkNHSitoM2t4QVo1?=
 =?utf-8?B?cDJBYUx4cTBwUW5MY2N0b0FsbE1RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yo+VN9TJ/whAA0iYzwK4Djm2YKMR/0fMgBwfbpKcjqcIc/kPWXtGN7iWDmk45P+JwhJjpLBZmZ80kf61dprmgdCm+gnq7fvipcFOgR6b3boveS99dOC+G8fTdl8hVj3rXCiLRNOks0ONFoJbfbVd3PrsilrEI0ZgBZpz2wR05hMQ1AC0MIdTPFGY+GJCPVbZc3xjNGJ1oOxSt9phZWgEQEus3/UJi4xz6din7ANHduQYOWaTtskysi7G9ZeAPSnalDcJt4G6NWz8vPtuSdfqLDwZLykPy8ZL75zatpJAp0NfROFftSohzlOFktPz+V+uQDYvq21iMg0+xNv847C3ekHSnMrBcd46a636PN/DQyFyKv8t640itiGXgXqsa/nZjIXJkF8W2nKl9+aHL8Gcyyb7nn9qSAtie0V2WTjWq4hx3T0AY5ZBk2y0ZYotujO7Q75L/Z3wk8IyK+OvEaA6rKHYG6XYrPcN1YXluIOlm71Cj/RvgE+7aXZ1xB1JEVcStUvLGh0KGckgn+4GvlJTi6ogdqMHcVH3NC9Pykq9UQpEdxSETWGxHVV7voKmYEjvP4dngxPPBmVKG6srLtEeMgYj4HtZlTPXGGHTUshEd1o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d064962e-aa17-47e8-35e7-08de2b56b2cf
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 12:40:50.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecvhdd7eB/O+OuRHUqWfjUMBiuvXQi1SOMNrUGhThkfwne4wgCSnznJ7o+iZc4ywcoAAsDQDBZNQ+vGDV4xVcB2pl1I2DypZoiWPiBWrltI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF92DC283F3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_05,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511240112
X-Authority-Analysis: v=2.4 cv=QPJlhwLL c=1 sm=1 tr=0 ts=69245256 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=BmP2q_L__UogPSo-:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8
 a=WgPesTf5qdGnbRkW2uYA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: S_VBPjfHX8PzK0kZU0KkJiqCJ8tXqZhe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDExMSBTYWx0ZWRfX8GmJgbaX33Ns
 7nxChgcMIUrIpKcNeQWtSDfU5NSaqW4Y7ZElmecDIGN/BgBma7i/oCQ08YGQEr9AiD3qMSG8NE6
 4d66TjQ+UgHgKEiedaWYvBCRn9KT9R+CHFfay3USOgnKE/L92w9h7p4TW5m9WXBBYMxbNWdJk21
 Zr3iGSpjO2Dv5B60jqqnGl7+/8VaMWPbEnGLtspPyGMQP6cZj3P4O7RvtxIIXxnQaES+ezD57/M
 hC+yVCx8wYGWvQBn9XlPcpXQ2gFBQitC5S4Qax4/JUU1Si1ZShei/GqU0FdkDMLtzpoWmd9ToY6
 O6lKNrXyWbFN5z3Ylh0NSqG4mgVR3LXfE7g985A0UUns8bx3ipKWVxmYzVv7YHJxFek/FWAJ4JH
 /FmDHSZzKPIg48B5uf17A9BkJRk5iQ==
X-Proofpoint-ORIG-GUID: S_VBPjfHX8PzK0kZU0KkJiqCJ8tXqZhe



On 11/24/25 13:26, Borislav Petkov wrote:
> On Mon, Nov 24, 2025 at 12:59:42PM +0100, Peter Zijlstra wrote:
>> On Mon, Nov 24, 2025 at 10:44:01AM -0000, tip-bot2 for Alexandre Chartre wrote:
>>> The following commit has been merged into the objtool/core branch of tip:
>>>
>>> Commit-ID:     afff4e5820e9a0d609740a83c366f3f0335db342
>>> Gitweb:        https://git.kernel.org/tip/afff4e5820e9a0d609740a83c366f3f0335db342
>>> Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
>>> AuthorDate:    Fri, 21 Nov 2025 10:53:36 +01:00
>>> Committer:     Peter Zijlstra <peterz@infradead.org>
>>> CommitterDate: Mon, 24 Nov 2025 11:35:06 +01:00
>>>
>>> objtool: Function to get the name of a CPU feature
> 
> Also, this commit name needs a verb.
> 
>> Boris just reported that this doesn't work on mawk, since it uses a GNU
>> awk extension (3rd argument for match()).
>>
>> Could you please look at writing this in strict POSIX awk?
> 
> The fail is:
> 
> awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 20: syntax error at or near ,
> awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 23: syntax error at or near }
> awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 26: syntax error at or near ,
> awk: ../arch/x86/tools/gen-cpu-feature-names-x86.awk: line 29: syntax error at or near }
> make[5]: *** [arch/x86/Build:21: /root/kernel/linux/tools/objtool/arch/x86/lib/cpu-feature-names.c] Error 2
> make[5]: *** Deleting file '/root/kernel/linux/tools/objtool/arch/x86/lib/cpu-feature-names.c'
> make[4]: *** [/root/kernel/linux/tools/build/Makefile.build:142: arch/x86] Error 2
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [Makefile:104: /root/kernel/linux/tools/objtool/objtool-in.o] Error 2
> make[2]: *** [Makefile:73: objtool] Error 2
> make[1]: *** [/root/kernel/linux/Makefile:1449: tools/objtool] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> ls -al /usr/bin/awk
> lrwxrwxrwx 1 root root 21 Feb 19  2021 /usr/bin/awk -> /etc/alternatives/awk
> ls -al /etc/alternatives/awk
> lrwxrwxrwx 1 root root 13 Feb 19  2021 /etc/alternatives/awk -> /usr/bin/mawk
> 
> That's debian.
> 

Ok. I am working on it.

alex.



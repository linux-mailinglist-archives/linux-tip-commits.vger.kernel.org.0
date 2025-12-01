Return-Path: <linux-tip-commits+bounces-7568-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E76BC9912C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 21:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83454343721
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5846B27054C;
	Mon,  1 Dec 2025 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EPFS1pP1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zHtzNFhg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4EE2749C5;
	Mon,  1 Dec 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621908; cv=fail; b=sXS+q/JEJRtYmk9makqa+NcCTp4CvCu/dqX2Ce0a19BrphV9AxYe1ODT7sx6hd2TKqW1e3xToFcwFVlAdtJSPnhRrfgCS4B77/yIa3o9qZdRRZIXqbEi+/F2y7NZs52YbyrFsk1Lq5q9zJI5E7SxHYAzkv+ysAARcoDqvtUTZ1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621908; c=relaxed/simple;
	bh=BpiAu3KlPLCj8Vg4gR3VXy7V86p1GpaZUnSUV1XV+2w=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NBC9N+bGgxk7D/wYMKk8Z2wTEavkoY154JN+fnAVfzQGzA3iDZUAW0sfGnnkY9/ywuAqDUx//xC+q73/XbdyJRhOsCiH7byHWmqcJpHiCJXQTrYhTe38Jo1pX9wDv+Q3TjcoNfjopea7QhMf6o8nj3JmGJtrdg6FxeAgnDEkkdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EPFS1pP1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zHtzNFhg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1FgOEU2301641;
	Mon, 1 Dec 2025 20:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zuA11+olKQgYCblPdTbw5RRSqEygdOPEkvS4uAPg3Tk=; b=
	EPFS1pP1idrIm4Cpi3xBiDRo5QZ3YNGzMHD3U8HmYuoYUGVPlto98nvwdXoq7aGO
	UTVUWzGzH2Z4CKp0jd+f6YOPlPyEJySd5Hrsl/dU5bw0sAUnGmfHjzEEnzsKFdZ8
	961GMvdeXc2s0fluxceeo5DynmUTpVqo84DqhyX23wFeiihy01ijbGZkgTdVUvY2
	LS9aXOcCBtTLMakVaeYa6dW9LiAhOc+IlRbzEQJnAe6Ab3V/cm8lX1Gi0bnRZrkC
	vmWRBAWUnLCpw9dBJeyvnQVvwjKCS554V3J19aS73TSMUl6qMipe//ypHR1WeH8g
	x7DL12MgzrVUOVd//gwzIg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7u7sdx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Dec 2025 20:44:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1IgWh4015055;
	Mon, 1 Dec 2025 20:44:49 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq98gt5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Dec 2025 20:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dq1wZjGXu2oe64oeicYv8FYneFsFgvi+iV0Dw+cYbCTlk4UKs2eaff+T4lUgckXj3NfmDnCJ18EKObOCId3CtsTEtSx+kvMRrDGKgz6VmKtQ8qjjCRh9E6FAfTo814tVOyhwTlrTb00Zttm0esIgFVgiuRqQM3dtNS8mHpzaxLda55kfXkWVYhle5zNJtKWKW36O/cRrX3+frm+clUdujvPH2md4+Y5v6R+viGGTYfm83pQJg2fFFXRBvZ9HH6giZdpKzVTB3/FPp37tGZT9tjkBKuMr1EPNNd49OSGn97SPvSmVCj+bud0OmuyiZIzQsBymV1vAEvke7Vxg4f7zCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuA11+olKQgYCblPdTbw5RRSqEygdOPEkvS4uAPg3Tk=;
 b=hA5mGoxiTjlD3NXE1btzGKHJ+75CZoX9SHYgzMdiEFukGogc35+pFB2fzUZK6AsmxmDzvvQhtUh6aZVSMj4wAcQ0jcWsKkv8asOU/KC6leZqakj1pesc5jIHJZoTnPaKYv6yXOhlqfCKHHJ3OC41m5I280uhv4xWbARiWFNZFUR4Y7T9heZvQ2Jg/6lSfPcxTTY28V46c3oc6Nnr64bHRHwSUMr3MzRf/teG/+hgMIF7Noaj7grZD+QagR9lZZVC3spTDiZ2lVoOPH0Z3i4sN3OS6RAqievvvYJBx3OCP3wOBjUGzo3YibCZ3l4scupsNHlA3R3IQha+ISQ4vrKAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuA11+olKQgYCblPdTbw5RRSqEygdOPEkvS4uAPg3Tk=;
 b=zHtzNFhgNuDLWfttz+DZbOrwYxHC0il07nqD+UuLFuNbsnobcmxiNWN5iVIw7gyD0+WmCIv30nv8aPiWe1BbnNwvAhJ0Aszk/UfpwIEDRqN5UH+ewzfUmsv8xxBWqsxx8b2g6BRG+2qlJuhOOddulWRx1DQ0oAa2OIMMBnNrEyw=
Received: from SJ0PR10MB5630.namprd10.prod.outlook.com (2603:10b6:a03:3d2::18)
 by DS7PR10MB5949.namprd10.prod.outlook.com (2603:10b6:8:86::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Mon, 1 Dec 2025 20:44:47 +0000
Received: from SJ0PR10MB5630.namprd10.prod.outlook.com
 ([fe80::5d5d:b4cd:59c5:196]) by SJ0PR10MB5630.namprd10.prod.outlook.com
 ([fe80::5d5d:b4cd:59c5:196%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 20:44:46 +0000
Message-ID: <3be480e7-8baf-4196-baf4-b9c29f8ef491@oracle.com>
Date: Mon, 1 Dec 2025 21:44:42 +0100
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [tip: objtool/core] objtool: Fix segfault on unknown alternatives
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de>
References: <176458277141.498.10249599680541531664.tip-bot2@tip-bot2>
 <bl3agkw6xvbnhfper6eljiawlkcb4mq4xjpourjobjhz6wozgd@5u35n26jtc73>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <bl3agkw6xvbnhfper6eljiawlkcb4mq4xjpourjobjhz6wozgd@5u35n26jtc73>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0188.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::11) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5630:EE_|DS7PR10MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d9e37c-af67-4ec5-729f-08de311a764b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djU2MVRnVVNscGpuMHcrMlp0NjF2aFVtU0Y2MEFVYkREa2lFdGIrSUdyLy9q?=
 =?utf-8?B?bXczWG5OdWMwak5WdTUxL3h0eGNKRVNxVlVSbWlZUFdkZS9HeDNzVW40eVhl?=
 =?utf-8?B?eVQ4VW1XQXZadTJMUTVLRVpZcTNxY0h6MDdYYlQ3WVZxbktOWVM1aUxtbEpv?=
 =?utf-8?B?WitWK3Fqb3ZMb0VIQVFwdkMyMjJ5OFlsMFZNN3ZGYWpOaUxOS1BiUXdGUHJD?=
 =?utf-8?B?U1BtbzN1TFFuR1dydVVCT2dOcjhGWkROTVd2aTl5eEd3K1FkcEdkZUw0UkxR?=
 =?utf-8?B?dDh2b3ZMaXFNVVVLdWpKWDdVR2pESDBFMnBoT2hJN3pRa3F0SEtHdlhjQVlS?=
 =?utf-8?B?bVhjVjdpdWhNN1BCRUVjZE1ZZmY3V1BGUHJ6MHp2d0R2bktXVVJWVXhRd3Ay?=
 =?utf-8?B?T1JBQ3Q1UVNvaXN2dWI5eDM3Ymk0RGxkTFJ0dDYxTTlXV1pqK2U2eXhiTkxH?=
 =?utf-8?B?UFdXRG9udXg5cVdhdThZM0RaeElyM21hbnpWViswRGdsVFlnZmNHU3hsQm1l?=
 =?utf-8?B?dElYSUNmTWRyMmx2OU5GSXYvSzRxUjFrTXZCdzhTN3lXL1lnajBZenFOVUl2?=
 =?utf-8?B?UjlaMjNPVmhlMGwrOFIyNFdSNWdVd2s1TDdBWFVFSUVoZ3FFanBRUXhWOVVP?=
 =?utf-8?B?a0VlcFpVY0hhVVpLdnkyQVJyb2lvWlFTSzFqN2UzZzBTM0ZqYVBSZlJ4L3li?=
 =?utf-8?B?OFRRUHhZVlNCbUVTbXNmYzR3TkxORzIyT0RZNkJrWkdWN0N5OUpNbmZ5UUFi?=
 =?utf-8?B?dkEwTWxGTWdFR0J1YU1KeGxWLzJaL3NxUno2QU5hUUxQMEpSSUVweXI5a3ZX?=
 =?utf-8?B?dW53eEVhbnBzMmFPUU15dkhtRE94cjllOWwyN0VMdmdQakV2QWxyUDZOWFBj?=
 =?utf-8?B?cVJoNEJ0S05WY2NJY3RzUkZGUHR2aTQzS09RaWw1cElVNWc1ZjdVaWZCb294?=
 =?utf-8?B?QkVKQTMvUHRHTUV1YzJNK2ptNkNtM1ZFV2lkeE1oY0RpaG5yN0lKSXFLaGJF?=
 =?utf-8?B?UlpMblozNlpMVGZuK2IxeVBYR0lHNVJTSFc3RkVIZEt6ZnA2UGpXcFNoYnVY?=
 =?utf-8?B?QnBBK3c5V0VqQ09oeU9HYkFDZng4ZGZtWEw4VGhaeEhBQkc5RXNJQU9XQWxy?=
 =?utf-8?B?SGlhOVRwbGJiRisyMnl3MlRJTDh3WGJqRUxVQUdzenJpU0tkYjRFd1F4Mnl2?=
 =?utf-8?B?U2l1NzBORStQTjQ2ZVZ3U1AvRENsRHc0TmRUdUJzN0QyeGpJTy9zWlVvZUhL?=
 =?utf-8?B?SXV2TU5KMXMxeE9CVmxKUmo2cDlLU24wRm9nZEZ3RmY4WEloaDBqYzM3TndZ?=
 =?utf-8?B?aVRpandpdzR4NElPSkl5d2RYMENLdmYwSXpEdk1vb1lEWENQdXN2L0FKcDVa?=
 =?utf-8?B?U0J5NnhPM2trdUI1TFBkdG82ZlFydXVndUZUbGRzSXRDM1JKcE42TzR4NTUz?=
 =?utf-8?B?UlVuWkwvVkx4VkkrTy8wRzUwZ0ZWaUplTmF5MjdrWFFUWnlzWDN5Rll3Qzgv?=
 =?utf-8?B?dVU2dzRieDFZMjdVcmRqc010Si90Zys5QkN0VzNMT3pjNTJYYkNEdW53c3JG?=
 =?utf-8?B?dktKS3NDWk5lRi82NW1OWEg2QWJlQ1lLQ3lNbG9OOVdIbW03alFtWXlYdVg3?=
 =?utf-8?B?MU9WZXV6THNidHRldzdpVXBkU2o3MnBLdkFWYjI4OUIxZFJDMkszZmVQUjlj?=
 =?utf-8?B?Y0xkNHRkMnNPa05sUDUwUk5jQktOR093aUJPRHp2SnRmVHIyc012d0VNMFp2?=
 =?utf-8?B?TEZQQjdHaVpXRzVWdU1ubEt2Z3U4TDMzN2NaUXNIaVpzZDNseFBZTFl2K3I5?=
 =?utf-8?B?V3JEdTE1cWttT1pQTWtEc2JUeUx0MUZuQzBGQkpMcC9hSHZyOUVTamVHVDR6?=
 =?utf-8?B?cjdpUDdNM1pKaHJmak1oSDZQbDdhcmJZcnlzejI1WVE3bVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5630.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVxY0swZVV3TVYzV3R6NURRdzlMTjZVVkgxYUdBZ1ZSM2dDZHdncmk2V0Fu?=
 =?utf-8?B?MDY4WUVNTjRDZ1ptRFBzT05RcWY4a1U4cEN5V0YvT1ZIZmpTQ3dhOTA3QS9s?=
 =?utf-8?B?a25ZelIycHdabjdLSzNzVUlOb3h2djNKVCtYWDdMQ0pQNG9nZ0NGWFhINTVP?=
 =?utf-8?B?K1lLRXJycWNua0N4Ykw3eElTblFCYnFpNFo3RG51RlIyU0lKRDVUaUk4VUJi?=
 =?utf-8?B?YlFleVJFNW5QMEY2RDZRUG10aHdpZnI2NGNENmtiY2dhN3lpZldJb1hUVkVC?=
 =?utf-8?B?aUZJZUdkQXMzaU1ycFUzY01hM0pXaEs1VTFSVDlPZ3dtUDJSOTNlT2ZsdCtL?=
 =?utf-8?B?bVFacldlbHE3bXV2NkdiMTJwcE5YREg1dUJPTzRkZnpBejVIczNUS2dRdHIx?=
 =?utf-8?B?bnNRcS9KTGRRUGY4UkRZS3dRRmR4N242NjBRM2NBOXVhSDFFUitQVlRTdE56?=
 =?utf-8?B?VmI5aHY5SzhRWC9udzMyTWN6TUpxOTZtRU52RnQ4NUJvdFBHdzF5Ny8zT3po?=
 =?utf-8?B?aWpjbU9Jdlc0anFpdjZldkxwVFFIbE5ZQXd0UWdqL1ZjdHRERnRTZnNBaHVm?=
 =?utf-8?B?ZjFIUk4yeWtqblN3WWpNR3diYUZjS0dEL1l6ZGFCM042WDZPMFNXaitLUGhW?=
 =?utf-8?B?d2hMVGtLM2NvSHI0YWNVYWlsOHF6eDc4c3pZRXJqUEhlY3h1amRLYTFjYVFi?=
 =?utf-8?B?R2RqY3Jxejc3eWNBWTFLTGd0QjRmRGdiYlpJNzA5clpUdDI3RFd2S2FIS091?=
 =?utf-8?B?Q3VRUzAvNiswbS9oUG5pTDFSZWZVWHNib0hveHRsbWIwbzN4bWwyMWlYK1hJ?=
 =?utf-8?B?VjFXN1BZNFJaZXNBRVYwR1lNc29ob3Q0TWx3ME4yWlphdFJ3T1cvdlFDT1U3?=
 =?utf-8?B?WEN0YXIxcmd4R3RCU216SU5TRXAzMkF6R3U1ZkNHdGRjWU90WnNLa3VoS0sv?=
 =?utf-8?B?NElVK0VOZjdPTUNaejVEOW16elZ4V3hIN3c5QUg0SU41Z3ZMZG4va2dONUxp?=
 =?utf-8?B?K2tLQjY1OVladXI3OElIN3pkUDE0U3NqMGtpZTlXN3J2dEp3UzYwMjRncmZu?=
 =?utf-8?B?eHpBcWc5c01DL3FXMWtJTGMvVFYrUnhkRTllUmQyRy9PWVJXSVNFUGxuOTh0?=
 =?utf-8?B?ek82NVp3OXhwK0hUcUxvbnlSY1JpdDBkSzJCSW5LcFM2bjh6MTU1NWd3N3p5?=
 =?utf-8?B?K1JLc1N5enpacWhkYUZ2M3lWSzdoQVlxTTlyQmNHdUp4T21URkYwTHlzTkxS?=
 =?utf-8?B?NFozOHhGcThsZ1VQWnhPRDBHaGdmd0RZNHJMT1M2RWliQzJvY25JMUd2M1du?=
 =?utf-8?B?ME9SKzFnTHBYajIxdUo5dGxING1zbXB3TkprQTAvZkxHZmpOZnhWZmczSGNP?=
 =?utf-8?B?My8xS0M2NHpvdDBBRHhGd0FxM3B2VTBEcmp6TUNpdXoyTnpqN2tMOThjN1lk?=
 =?utf-8?B?UGJibWMzYTJjLzhYWXk4VWw5WTdKb3hQbGlBQkFPVCt5eUhVdzlNRFBrMEZX?=
 =?utf-8?B?M0VOLzVEdWZ3WW1IWS9laXUyUUIrYW1uK2FXY0hFQmYzWUFSRTU1UG5CZXZS?=
 =?utf-8?B?N0xqay9SQjhHUytMSFNzSUNpZjgzQ2M2TWlFOGVJV2grVjdnaVZ6RTQ2eWc0?=
 =?utf-8?B?MlliUm96WXZxZ1pjN3dmelgxQld0c3NlWFVEYW1aQTVXVmhLNDJkQWFYUDg5?=
 =?utf-8?B?cjVMUk1aVmV5RjJJeDBVM05YUk1aYnBmZnFhdU9uSkluMCt1bGNZUTRCbE5B?=
 =?utf-8?B?R2kvK1N4R0tURVNZOWpzTTBDTnJBZDAyUVFhM1VNdlJlMVZiWjAyUDNHa3dL?=
 =?utf-8?B?T1ZBYy9PV3BBRy9xSWdGemRYTkRVUm5SMnVwYzNOSmxOemgyZUhXT1RnWFVL?=
 =?utf-8?B?dkg4eXEwdno4Y2dqM0hlR0hnTmZsMmw4WFR2Q1dRbVBPZjgxcTNmNlF4WUt5?=
 =?utf-8?B?QVJQc3FsLzJRaCt1b1NnNjExRzJMdGY1UE9HWFFydXN4VFVTSUVDaUE0SE56?=
 =?utf-8?B?L2kvbDhyWitLa0JEait5QmhjRDcyNnBGcXZIQkkwWEpZYkQ1WXpKOFVieFhw?=
 =?utf-8?B?VEVlZGVxbVo1OURIczdzaU0wajNGVFQ0eHRZWTZBVXBsVUlCNUdPYytJRkIz?=
 =?utf-8?B?bmNnVk4yaVJIeUtoNFRQTTF3OGNBbXRFT3ZTNFRnL0lObDdSRGhWbE9Ba29C?=
 =?utf-8?B?UzVqUHZyV2E3QlBiUWJMOGtkeUIyQnI2eDBmV0dGa0ZmdWxUWStuMG0veDhH?=
 =?utf-8?B?enA2WnVXMlVpRGloaVRXZGJhcnNnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4mx0GZuwPts6OBPY4uXOUguntJBqxujUp92pzfFgwwncDx9OVyPtlXNd4Co6bmroQBpzJ3gTCfwwURbVLN6i9pYIVpQaC/eo4l4Vngw7Pw09zef1+bCeKcdQ7IsoY5TzUBjEBs9K27ZHVdfeaB6Y9IuGJi7yB2ie4mL3hAam/8P0SI8rnNMrjPpQFbWm8d8IX7wISsfvHbTSI/wsJ4lnCHkWUwgKcn+d9lCVFY3inYFQmNVq6z5ttMHy7nevwwE1msYM0cNQb+3yMDDKNetB9zC6iGnRgy8DYhG0rTGSr1y8KPE88tMczoYHW0nnwp+3mrNMsd3Ixb42eABRNGsOMb9FKi8S2L8S+mkOnI2vhGYj7z97TnheMuyKdpXH6KCD54qqONqJWHqnevDRQdW4jscShnbLTw+UtUZKC/8RMpebdWigsZRudQ3MJQ5NlpHu7/06VpHAC9P+fa6fSpDKlU7PGersF12HHJmcpsT1XK0eEX1TuQCcJVimR65mUYbssWz4XkG6nh7Otb0Z1jOzUQOgRSHXgFAteBBXDkVt9L/hE7X/WPkWhrFEooIno8cdGg18+I46ZnpI+S/MDLtNIQFf7W0j5eXzO5BADHae6Uw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d9e37c-af67-4ec5-729f-08de311a764b
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 20:44:46.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKsCxhVbqctASo+dws/J5fP4R1Rghjmvqow1oLL+iQSBL545ze57kCrqifTGg0e+xfOMMbaMQnVGdYO1Hm/M8Q4tzoxmKh69xyFIjwb20I4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512010167
X-Authority-Analysis: v=2.4 cv=Rfqdyltv c=1 sm=1 tr=0 ts=692dfe42 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=hgy4wULiCyz86y5la_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rc7YrgxZRG7pXnyhA4FMvDIoq7kO9Jp9
X-Proofpoint-ORIG-GUID: rc7YrgxZRG7pXnyhA4FMvDIoq7kO9Jp9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE2NyBTYWx0ZWRfX9uqmvQSNWJmC
 rwb7x7pmKFkPb/JJMeVrA6kzY5g0RV+2RDnEkpBXsoJO4mDowfixf/2RQtZdFNRI7QonEZTHEuo
 7AVpCs+w8an2ElYWM19q7NmeOKy/o0ttyDaUp5D+Z3MxTXLVVHRzGDPmgPcelTV6HTSxD3fAEOq
 b74QMisCZrbvwmAOBUl5HmoRXiZDW1vjUvoKUlEXkticZhIpdDY05eZu8xPoMcoH2/1dD9n+MbW
 ts8g+uOqI9VKkfxVzKft7ll8vbp3j/n9J2kMWG6y132iabj/Z6vuW40NtJOjxxICHTAG39oPNbQ
 OytrKEFAXZiqhfXTna7TD1FfINYwTcv33pZHgp8dE4L7dtjkhELEiYMXaP1o6guApFA7ak0D062
 ngT2/pOoAgPr2+1Pv06IXqwdPOkogQ==



On 12/1/25 21:05, Josh Poimboeuf wrote:
> On Mon, Dec 01, 2025 at 09:52:51AM +0000, tip-bot2 for Ingo Molnar wrote:
>> The following commit has been merged into the objtool/core branch of tip:
>>
>> Commit-ID:     6ec33db1aaf06a76fb063610e668f8e12f32ebbf
>> Gitweb:        https://git.kernel.org/tip/6ec33db1aaf06a76fb063610e668f8e12f32ebbf
>> Author:        Ingo Molnar <mingo@kernel.org>
>> AuthorDate:    Mon, 01 Dec 2025 10:42:27 +01:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Mon, 01 Dec 2025 10:42:27 +01:00
>>
>> objtool: Fix segfault on unknown alternatives
>>
>> So 'objtool --link -d vmlinux.o' gets surprised by this endbr64+endbr64 pattern
>> in ___bpf_prog_run():
>>
>> 	___bpf_prog_run:
>> 	1e7680:  ___bpf_prog_run+0x0                                                     push   %r12
>> 	1e7682:  ___bpf_prog_run+0x2                                                     mov    %rdi,%r12
>> 	1e7685:  ___bpf_prog_run+0x5                                                     push   %rbp
>> 	1e7686:  ___bpf_prog_run+0x6                                                     xor    %ebp,%ebp
>> 	1e7688:  ___bpf_prog_run+0x8                                                     push   %rbx
>> 	1e7689:  ___bpf_prog_run+0x9                                                     mov    %rsi,%rbx
>> 	1e768c:  ___bpf_prog_run+0xc                                                     movzbl (%rbx),%esi
>> 	1e768f:  ___bpf_prog_run+0xf                                                     movzbl %sil,%edx
>> 	1e7693:  ___bpf_prog_run+0x13                                                    mov    %esi,%eax
>> 	1e7695:  ___bpf_prog_run+0x15                                                    mov    0x0(,%rdx,8),%rdx
>> 	1e769d:  ___bpf_prog_run+0x1d                                                    jmp    0x1e76a2 <__x86_indirect_thunk_rdx>
> 
> The problem is actually that indirect jump.  That's a jump table (not to
> be confused with a jump *label*) which is an objtool "alt" type which
> the disas code doesn't seem to know about yet.
> 
> They're used for C indirect goto (___bpf_prog_run) and switch
> statements.  The latter are currently disabled in most x86 configs via
> -fno-jump-tables.
> 
> They're indirect jumps with a known set of jump targets.  It should be
> possible to graphically display the possible targets with lines and
> arrows, something similar to "objdump -d --visualize-jumps".
> 
> If the code isn't expecting that "alt" type, it might explode in other
> ways.  So at least for now, those alts need to at least be recognized
> and ignored.

I think the problem is with add_jump_table() which creates a struct alternative
but doesn't set the type. So it defaults to 0 which is ALT_TYPE_INSTRUCTIONS and
then it fails because an alt_group is expected with this type.

A quick fix is probably to define a new alt_type ALT_TYPE_UNKNOWN = 0 and have
disas ignore this type of alternative. I will work on a fix.

Thanks,

alex.



Return-Path: <linux-tip-commits+bounces-7516-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395D9C81A38
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 17:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0443A2ED1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7229BDBD;
	Mon, 24 Nov 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ly55txqW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nkj4iFPN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881B9289E13;
	Mon, 24 Nov 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764002613; cv=fail; b=VvARLjtEVxvZWG+mLr3RO5n3/YUNweblTmEXRfn6cgoQSV6pGnVNVldEG72cVqRTcnH7rNdwbojXGP5ce/VqP2nZKkzHGyZi5ZYRwHJ/aETow5DNlkYRQWyD/tEVho8CMmbxYLlELnuwKuj+ZDRdaIiWv3I4IQ7vFXt0RCXEUfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764002613; c=relaxed/simple;
	bh=uZkm+51Nci1m2bD3PMvf/ZK1qWcsuj7V5JQpVgmdfbY=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z5qbWa1W4+4O6B+qTFWap2qTD/2A2NyUpVIbLeo/PHSBSR56L8hl+Tz9gmhtO6yrH9IxkZe/i3fd5Ceus+NR70v0khcbvKCPXZWRfG3Us1IsdcI6JdwxUXmhUOtiHykeUFQd8laqSk17T+rOomG28YFQlVyRMZnEWfVNwZz6tog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ly55txqW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nkj4iFPN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AOCVGNu1038231;
	Mon, 24 Nov 2025 16:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xYjLlFIdXofgkn5SAl1l6YSrEP1UuBBkzNlc+D3T0xQ=; b=
	ly55txqWFvgMFZwh94y0wnw05PM1wHXZzzlDQCKGSJdOordVyeTUda5HObYy3+Ah
	bGFbsrojXn57NBv1in45XdU2MPfaJNgb0s+/2FUPStWdTC3m7kfTSl8m2bsPYiN9
	2UYNhkBbIBZWcAmiskTcScUpGTzQpnuFD+35ZiBVv7QXTgvQphBgg3EcO/Px/Tqx
	lsZyhepxGbqsDQPBzOYf2yYpopOS+S8OekPpdialiE5LvbcMW0SkGsi5KrZD99tk
	Di5Qg8IYw2sAdINp0M17QM4kugG81+Qz4gpNLA9uYz3fQ8mnZSSxLYPJVtMqmRrj
	R/tK0t1zg/mawTyLIWoyjA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkad40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 16:43:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOFhKSi018823;
	Mon, 24 Nov 2025 16:43:12 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3m8b27x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 16:43:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gJBywLnXG9n6U2ANhD6pPrUeCRR5/7yUHjpGgmzwFk9aHEyQDt43BXL1noRkC0wH2u4RItlosj8KYA/Ap4X48gRqDljbI+t3JeYC2VqhWmfV21ZlqvsaMrxjez+AV715JpGqi2KQCHvMXU41EUl+O6CC9oDS8H/0ixPY+d7c5Q99xVH8PVeSi984EKWAavjqCu2xS2Fyfgs/zMrKsUtHKIWlD7c67slo91zrlIBbx6X3HiZAbmmwZkbGRJhG1o/6vdrsSJmJU2AG0NXhm1glCKIZ5dCPYNN8fzTdscFj7s+UhrzS18eKAJ+w5meTW9E7MHxVWGz8AErzLRZh9pKkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYjLlFIdXofgkn5SAl1l6YSrEP1UuBBkzNlc+D3T0xQ=;
 b=YKQgq3Oiv5q0phDsdcdw6z9GBX/MF4y/cMTGTBmAU+HznXC2XDLjtQz4/qQlp5YB30o1FvAmEU7U/yIOLoMwz6IVcM3yYGjpIeTgWfwva9xzy/kg5+TDtEWbaAvVZv9XOYqzoP7oiAWWVk1a4Do+b2+Yijadu1j+iFI6M5yroX5YfNAtiuMWfNgAGuvCm41JO7akQkBbCIwnj4FinMQZ/DTc93MF1CRbkGoioNSa2r7pGSXjT77T7lKevkgNxXLHMmpoPkIxqSYV/WWmUspRxxvAQZJ29PtJBBVIWply4NPsrsT5xwJoXpHQazJZRYvOJifm4PcjXbr8P8/kwwGAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYjLlFIdXofgkn5SAl1l6YSrEP1UuBBkzNlc+D3T0xQ=;
 b=nkj4iFPN+BFD+4FK4o1oPPF4LX7ya/P4EcGj2FpZONr2z9qHLCDE3hRHW2tJES5BquKdxTCAWlVKsp4Iw7olz9psdyj4SVGG1zQKxLbgRlAZempe5leWFcC1vrd7PrAysiXDlULTh6MRb8zwiALZk3NMeY/TXjilhNvaovWVc0k=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 16:43:07 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 16:43:07 +0000
Message-ID: <cf0ecf1e-6d7c-4d5e-8f8a-27446b801c94@oracle.com>
Date: Mon, 24 Nov 2025 17:43:04 +0100
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
 xsFNBGJDNGkBEACg7Xx1laJ1nI9Bp1l9KXjFNDAMy5gydTMpdiqPpPojJrit6FMbr6MziEMm
 T8U11oOmHlEqI24jtGLSzd74j+Y2qqREZb3GiaTlC1SiV9UfaO+Utrj6ik/DimGCPpPDjZUl
 X1cpveO2dtzoskTLS9Fg/40qlL2DMt1jNjDRLG3l6YK+6PA+T+1UttJoiuqUsWg3b3ckTGII
 y6yhhj2HvVaMPkjuadUTWPzS9q/YdVVtLnBdOk3ulnzSaUVQ2yo+OHaEOUFehuKb0VsP2z9c
 lnxSw1Gi1TOwATtoZLgyJs3cIk26WGegKcVdiMr0xUa615+OlEEKYacRk8RdVth8qK4ZOOTm
 PWAAFsNshPk9nDHJ3Ls0krdWllrGFZkV6ww6PVcUXW/APDsC4FiaT16LU8kz4Z1/pSgSsyxw
 bKlrCoyxtOfr/PFjmXhwGPGktzOq04p6GadljXLuq4KBzRqAynH0yd0kQMuPvQHie1yWVD0G
 /zS9z2tkARkR/UkO+HxfgA+HJapbYwhCmhtRdxMDFgk8rZNkaFZCj8eWRhCV8Bq7IW+1Mxrq
 a2q/tunQETek+lurM3/M6lljQs49V2cw7/yEYjbWfTMURBHXbUwJ/VkFoPT6Wr3DFiKUJ4Rq
 /y8sjkLSWKUcWcCAq5MGbMl+sqnlh5/XhLxsA44drqOZhfjFRQARAQABzTlBbGV4YW5kcmUg
 Q2hhcnRyZSAoT3JhY2xlKSA8YWxleGFuZHJlLmNoYXJ0cmVAb3JhY2xlLmNvbT7CwY4EEwEI
 ADgWIQRTYuq298qnHgO0VpNDF01Tug5U2AUCYkM0aQIbAwULCQgHAgYVCgkICwIEFgIDAQIe
 AQIXgAAKCRBDF01Tug5U2M0QD/9eqXBnu9oFqa5FpHC1ZwePN/1tfXzdW3L89cyS9jot79/j
 nwPK9slfRfhm93i0GR46iriSYJWEhCtMKi9ptFdVuDLCM3p4lRAeuaGT2H++lrayZCObmZxN
 UlVhZAK/rYic25fQYjxJD9T1E0pCqlVGDXr2yutaJJxml5/jL58LUlDcGfIeNpfNmrwOmtUi
 7Gkk+/NXU/yCY17vQgXXtfOATgusyjTFqHvdKgvYsJWfWZnDIkJslsGXjnC8PCqiLayCPHs+
 v+8RX5oawRuacXAcOM66MM3424SGK5shY4D0vgwTL8m0au5MVbkbkbg/aKDYLN33RNUdnTiz
 0eqIGxupzAIG9Tk46UnZ/4uDjdjmqJt1ol+1FvBlJCg+1iGGJ7cX5sWgx85BC63SpKBukaNu
 3BpQNPEJ4Kf+DIBvfq6Vf+GZcLT2YExXqDksh08eAIterYaVgO7vxq6eLOJjaQWZvZmR94br
 HIPjnpVT9whG1XHWNp2Cirh9PRKKYCn+otkuGiulXgRizRRq2z9WVVQddvCDBDpcBoSlj5n5
 97UG0bpLQ65yaNt5o30mqj4IgNWH4TO0VJlmNDFEW0EqCBqL1vZ2l97JktJosVQYCiW20/Iv
 GiRcr8RAIK8Yvs+pBjL6cL/l9dCpwfIphRI8KLhP8HsgaY2yIgLnGWFpseI3h87BTQRiQzRp
 ARAAxUJ7UpDLoKIVG0bF4BngeODzgcL4bsiuZO+TnZzDPna3/QV629cWcjVVjwOubh2xJZN2
 JfudWi2gz5rAVVxEW7iiQc3uvxRM9v+t3XmpfaUQSkFb7scSxn4eYB8mM0q0Vqbfek5h1VLx
 svbqutZV8ogeKfWJZgtbv8kjNMQ9rLhyZzFNioSrU3x9R8miZJXU6ZEqXzXPnYXMRuK0ISE9
 R7KMbgm4om+VL0DgGSxJDbPkG9pJJBe2CoKT/kIpb68yduc+J+SRQqDmBmk4CWzP2p7iVtNr
 xXin503e1IWjGS7iC/JpkVZew+3Wb5ktK1/SY0zwWhKS4Qge3S0iDBj5RPkpRu8u0fZsoATt
 DLRCTIRcOuUBmruwyR9FZnVXw68N3qJZsRqhp/q//enB1zHBsU1WQdyaavMKx6fi1DrF9KDp
 1qbOqYk2n1f8XLfnizuzY8YvWjcxnIH5NHYawjPAbA5l/8ZCYzX4yUvoBakYLWdmYsZyHKV7
 Y1cjJTMY2a/w1Y+twKbnArxxzNPY0rrwZPIOgej31IBo3JyA7fih1ZTuL7jdgFIGFxK3/mpn
 qwfZxrM76giRAoV+ueD/ioB5/HgqO1D09182sqTqKDnrkZlZK1knw2d/vMHSmUjbHXGykhN+
 j5XeOZ9IeBkA9A4Zw9H27QSoQK72Lw6mkGMEa4cAEQEAAcLBdgQYAQgAIBYhBFNi6rb3yqce
 A7RWk0MXTVO6DlTYBQJiQzRpAhsMAAoJEEMXTVO6DlTYaS0P/REYu5sVuY8+YmrS9PlLsLgQ
 U7hEnMt0MdeHhWYbqI5c2zhxgP0ZoJ7UkBjpK/zMAwpm+IonXM1W0xuD8ykiIZuV7OzEJeEm
 BXPc1hHV5+9DTIhYRt8KaOU6c4r0oIHkGbedkn9WSo631YluxEXPXdPp7olId5BOPwqkrz4r
 3vexwIAIVBpUNGb5DTvOYz1Tt42f7pmhCx2PPUBdKVLivwSdFGsxEtO5BaerDlitkKTpVlaK
 jnJ7uOvoYwVDYjKbrmNDYSckduJCBYBZzMvRW346i4b1sDMIAoZ0prKs2Sol7DyXGUoztGeO
 +64JguNXc9uBp3gkNfk1sfQpwKqUVLFt5r9mimNuj1L3Sw9DIRpEuEhXz3U3JkHvRHN5aM+J
 ATLmm4lbF0kt2kd5FxvXPBskO2Ged3YY/PBT6LhhNettIRQLJkq5eHfQy0I1xtdlv2X+Yq8N
 9AWQ+rKrpeBaTypUnxZAgJ8memFoZd4i4pkXa0F2Q808bL7YrZa++cOg2+oEJhhHeZEctbPV
 rVx8JtRRUqZyoBcpZqpS+75ORI9N5OcbodxXr8AEdSXIpAdGwLamXR02HCuhqWAxk+tCv209
 ivTJtkxPvmmMNb1kilwYVd2j6pIdYIx8tvH0GPNwbno97BwpxTNkkVPoPEgeCHskYvjasM1e
 swLliy6PdpST
In-Reply-To: <20251124122639.GBaSRO_-G9dUtVHMaY@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0024.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::11) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|CH2PR10MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: 299e6ea5-1139-4c19-9b97-08de2b788bcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWQ5YjFFbDltMEtZZHJtNzdQL0hZNS9QS2NMRFAyRHZUQ0NrWGxpcFIxVU4z?=
 =?utf-8?B?bDFweVIwT3BYSnIwTUdBWnphenFqQUh6Z0dVY25DNmxqMy9iWEJIMW1FVnEy?=
 =?utf-8?B?MlFMTDZtRjkzbUF4bVZKNnRyeTVoUng5bytmaGx2b2l6RzFlZzh6VE03NzE4?=
 =?utf-8?B?WVRXSEFoRmVIcVR1dmJsUnNWTlBiZXlRc0lSOGdvWmo4TTQvQ0VJZGphdi9s?=
 =?utf-8?B?d3RsZWlUMXJrZUprNFA1NmhadzM5M2RnOW94SllFdzVHOHozZ05tV3ZBeDlV?=
 =?utf-8?B?cmlnRGpjQU5qMFB4YUtLSlpWOGFOSitLLzlIbzlJSUx0L3hiK05SVzhnVk0x?=
 =?utf-8?B?N0JtMGJ2REtaVDlmOVVvSUdqcjdzakk2a0ZkK1RXOE90S0JvVXh3akpEWFVJ?=
 =?utf-8?B?dy9qUjBBWllLQkxJVHRyd3F6NTZHaFVVVnJPdnFLdnJacHh5MVpVRDM0MmhF?=
 =?utf-8?B?TTlyWFNTaXRzWWhuRnlRT3c3ZXZBemZhdDRwdkRtNk5wOWlDMmNqZEJheXBk?=
 =?utf-8?B?UkEzU0RDdU9VWEZiWG5SdXhwajUwTmN0OXE5eUlqMHpBM3phdWd3d3JwVkg4?=
 =?utf-8?B?UWZ1ejM2VUg1WHdmcHVzaU52S0RhVTJ2VkRYSkNKdjdKbWZmdFJPN3c3VkFj?=
 =?utf-8?B?ZWFJVUZKTWdrNUpJUEh0NGF0ZU1WTFRZRzNITDJEVWJhTm9DS3MrdFhKU2ho?=
 =?utf-8?B?akpaUUtacE9SeEljK2hnTnBZc3J6dEdaN2RwYzdNdkFkUE1iZXc3aXMraWd2?=
 =?utf-8?B?TzBjUnhHbUtWc2ZRMVlWRlE1QzAxUzc5MDIybnB3azUzNUdhblNpUEpnajFH?=
 =?utf-8?B?K1lUTFNzN2hzRkFqa3ViNFUxTkNYaEg1cUdkQ05XeWZhUmhiMkRPRkRFanVX?=
 =?utf-8?B?STZQUkQvUVZrWEVuUXNKdmNDcXFCZ2p5MDZZTGM3YjZpaEw3Y0w3ZVJYVDFM?=
 =?utf-8?B?MktzUVZON3QyMVhxWVFCUmFNZVBpajVJbVI2aGMreFFSMGZiZ3JabWQ1TzYx?=
 =?utf-8?B?ZlNTVzRTZVhZOFZPbWFlVjF1Mm1BUjFjTWRQQnlJcWt2eUNJS2prVTNmMlky?=
 =?utf-8?B?Szh0SUJzNVQ4SmdYMm5qWWJHQ0ZBZzZ2dFJyY2VlcWNPdnU5ekQ2bWk2NW9t?=
 =?utf-8?B?NUd1cFVhUGJ4U0Jrb3BVUzQ3bnd5MEhTVGEyUWdpUlpodE8wZSsyN1FJUytZ?=
 =?utf-8?B?eDlNTnRIYTJvU0xPR0dYaWh2eko2ZFlLVC9aTDVmeXJrNHFJZW5mb0FvY0VQ?=
 =?utf-8?B?TmVsQkpLTDl4RTlXdEJPako4RVp0VkZ4dm5GaUgzREN2Y1VCbyt0L2RYdHk0?=
 =?utf-8?B?V09LYm8wNFl2M3ZuNUg5TU1aRnZnZlhYYzZPcElFZ20zR2lwTkxVdzdTUkNK?=
 =?utf-8?B?a3gxYWhPQStFNEJKdnIzSzMvOHZ5T0ZINk5BTUtSVkhOS3d5OUxDSjRZSzFl?=
 =?utf-8?B?bVNvZlI2WGZ4ajdoOUNuRmlJVDdPZzRqdkR0d0NJZ2pFenpJTGRkZ0FaRitm?=
 =?utf-8?B?RUZRZXJDZWtQYWhLWm95Wlp1aFl2cFV6NHFHR2V1Z21BWTg3dy9FSzVpeDVm?=
 =?utf-8?B?Mkw1WFY5Sys1ZUZYYUdkUWhjaW9YOUV6MzZFMkFmTkdVWnlld2s2R0QzdE5N?=
 =?utf-8?B?cGowbzVHNXNEa3JCc0xIUnMwWXQvcGJaOWVkdVpDSUZZN0FHelVHMXQzUEhp?=
 =?utf-8?B?amNmOVg0c0pMUkU2WFNFL1BzNlBPRGhxT0xHTU9BMFZBR29EQ3g4ZDlkUWs4?=
 =?utf-8?B?YUVYYVlGZkZHTjJVb3dwTmh3R2VPTzB2dTYyb0FmWmhza1RIU0QrbHVqM2lC?=
 =?utf-8?B?eGc5WDBZL2pvOEQ2WW5TQmlJL0w4bVpnd21JK3FJa2xuTlRTRlBWbmU2Y1U2?=
 =?utf-8?B?NVBJN01VR05jYVBnOGxvM2dvVE8zQWVucWpycHBDL0g4ZENlWHMydGFCMFZZ?=
 =?utf-8?B?dUtLQjB4ZHFpaFFQOHFwUVhNZlkyb1lOSTN3N0F2NTNLN1pkNW44MkRRd1dU?=
 =?utf-8?B?NERWWlhqZE1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU5CQzZQMU1kNC9Zd1VROTlBNERzNyszY29YUVdPQW1qUnAyc3F6SzU0Rmxj?=
 =?utf-8?B?TGloY216d1lsZmM2UVR1NzdXdXR2Y1ZwYVFocDZZU204WHFqZVNlZkNHWjZK?=
 =?utf-8?B?ZHVRamh5MnZ3eVRudW1kMHR4YUwrRW9ZaTlCdG1VN1N3RC9KSTZQd0F3VVVD?=
 =?utf-8?B?UVNZWjVNdFBIcklRMC85UlJWQkJveVVTTzA0VzFsZUxBQ3JSOW42Q1NQczJ5?=
 =?utf-8?B?VDNjSkhtT0doUTZReXBLYjk0VTdoNE9BTlhVcDFOWGtwUGF4Qkl4aTlmQmU5?=
 =?utf-8?B?eUFNQ3hOaUlzeThkR3RKbXhJTERHRHV1SEgvZHZkOE5RVmZnSmw1L3pXd3cy?=
 =?utf-8?B?Mm9PNGF6NitsQURuM3FEdGtNWXk5UkQydm40Qm1NN2xrdkFlNmFoT1gyTUJD?=
 =?utf-8?B?ekZ6cDYwSlVBdU03SUMvUGFSSktvRll0d1h3dGcxREdkTGEwTll0WE5FM1Ju?=
 =?utf-8?B?V3MrWDJZSXNpZEhpZzRZMDB0Y3p4aTFtZ2daekNtT0JqTExCOEtHcmhVRWZr?=
 =?utf-8?B?TzZiTWloVnMxcXFLSmFqMVh5bU1ac3NQdkRhMWQrcUxxUHBDL1gwQm9WVG1y?=
 =?utf-8?B?cHIwSkt1dEJIWnYyYkcvbUxYR3F4OG5iQi83bXFRbU1SWXk5blZoelErNldY?=
 =?utf-8?B?dU1hOU1veWpvZVJMR0lUZWpEdjF5Qy9GZkNuT2ZUeEQwNmcxaHJiR1RxZFhF?=
 =?utf-8?B?SFMydytOUGVVd09XNXNBSG1LVXJIaUxybENPeDR2YmVsVHVqTXBzcllldDdQ?=
 =?utf-8?B?bytEaWYzd3NDNVNXL0lINzVoWFFOSFQzSUNSMmQ2aHFWeWo2R3lvQ3hlUjlh?=
 =?utf-8?B?aUZxODlwMXZiWE9lbWh2UE1hWmFVWWFQYzBrNHAyQmtBcE5GWkt3dDdacnRK?=
 =?utf-8?B?ZnlWZXkvd0VCVU9YV1ZBSSsxUlJneFVKLzQwQXNnbkdaeEtqSnJLaVFQem1V?=
 =?utf-8?B?dHVQS09PTGxiUVVCcUN4ZXI3d3A2OUNtQjRMTE5aaTFaU2tGbUhxVEdUNHBI?=
 =?utf-8?B?dHEyL2RZYlNqUnFVeUpOQVk3UmVEZ21MNFlxTmhzVStRcHpPWm9FOVhELy95?=
 =?utf-8?B?czFtUUlnVXF0QUxjTzdvdTN4NlZaZkFpM1NNWkdpeXNCZ1drZS93aTJWWnpS?=
 =?utf-8?B?RmRibGFjak1SUXV0UWQralBtUi9LWC85dm02RVJ4aWl6RjBFb2txQmN4T0lW?=
 =?utf-8?B?QXJlUXJ2b3ZSd3UwUXAyRG95dlRhVlM1SHFYNmQ5T2dMS0VLeHMydTJzNzYy?=
 =?utf-8?B?VzdTVEdDNjhYQmFYVlZJV0phMFNEdlg0SmlXN1k1U1JFeWRUTnQyT203VG92?=
 =?utf-8?B?TWE0ckV3Qnp6cGZid0RlVzRYZmozUjhSemV6SWszWExFdlcwR0NQb3ZqV29Q?=
 =?utf-8?B?R3dMZEp1N0FiZGxBWHBVbmZBRE12ZUhPbFo1RzFFRm1RTWhRaG1jeEp4QVNw?=
 =?utf-8?B?TklzR2plL3k4MW5DdzRGYmhQWlo0ZzYwajF3OTdISEJEM3RkbmhHcDVXditP?=
 =?utf-8?B?VlM1bXlWWHVwNjFiczBUVXYwWG9vb1Joemh3QTJNTE9Qc01ZcXNEK1FUaXNT?=
 =?utf-8?B?aTAyKzEwaWZhMGVoNnVkL0ZPZXJySHk2NWFoOStaaXUwYWIzMGovNWhZdkJP?=
 =?utf-8?B?bkFMNVdGcjdLbFk2Q1N6QVQrak5IM1dySWVMaGpjVjZmZEMyY2VubHhwUXZF?=
 =?utf-8?B?b09vb0Zwcmh3T0pybGMrT1JFTGRpZlpYVFVBUDZpMUdMaDlSeUJHWFVxTUdj?=
 =?utf-8?B?OU96VzFMYlBzcEw0TnpHK0NIUEF6a0JuWGtmOUUwVVFQMnNEckUyNG1yckdP?=
 =?utf-8?B?cW85ZEJvYXNrTnFxK2x1K09SeFNPeEF4S2FYcnRPQWs3RFJzT1B1SDQ2RUlI?=
 =?utf-8?B?TXE1WUh1YWJ3OEg0dGRMcVNITCs0THFuUEErZUIyQ3V1aXlhaEkzbUZvd3BO?=
 =?utf-8?B?UzQwVk85dkw2Z3p5ZUxCNzF6WFVFV0EvTCtEYXpXd1pxUEpsc21penZDcTZi?=
 =?utf-8?B?M0pwdUNzMElCQWpZYTBSVGZwRW5qUVNFaHlzS0VISG0vYTI5SHBTb1FycEg2?=
 =?utf-8?B?SzRxYkhmakZZY2x5Q3VpVnRBc3JJSUczOHBUMVFFenRvSG9senlqSWdCbitL?=
 =?utf-8?B?WnM1VzNCcXF0cTBmU0RubTdWaURTenVPak1WV3E3bVhIeWIxY1dxQ2dlSkRI?=
 =?utf-8?B?WDJGd2xBQTd2cU5zVGVaNTVseU9EaDdWN3ZVUWNEQngzOU0yMGVjTVd3RDFh?=
 =?utf-8?B?dDhxOFhZQ2t4ZXI0RXl4NnJkSlhRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gns9eqx/S39jtHVREypIPJDCukYViM2mtJEQaluoMaHMzgvkBx/sx1gOGjUNfhKjO+BGNuEpREWj8rPKAG7t/ax/YHUhP+HuyTlaWO2vAohig3mLxzBUyt4xmHm3BWQFIBu1qhKkP2Q4D3nNdnrQbk+A7WVbi6y5/G8ph3hjAn2UAU7krsHIh73+5lNhAGYXeGn/aUl6boEzyu0gUBj1hMHhKqt4QZm7eo7GwGu674bEU04BtK8K4/2ICnHRIHxZ5UOoUkgB2paHur/MC12XKDaQRz23zuwGo8Pzt2MIRfGQYT41jjeyYn981ATpqKtmUpy4NuOQVNGgMq0Pt1qIo7D06xSSELetzL1Y+e4QcwC5MGw12WDD+4Nyd+LmuNJg2K/bsOtA9PJ2oeGJtRcjshoTCFg2L3MUmhuPjdCgowCujj12reycnXWf69IJdRIySgvdhFbr7tEtr4AdkdGt00JUJQLXOvF0Ic0jBjktOPpQGBE6zsfsFl55y1vJaYmPad/69JZUifk/n3OSqQi4c0w9O4ZDZtqM16TVu1Q6jDFGzariYPotlYbQGxkBr3myz6AkZiHulplKf2ML9/d6vMLqtczmOUi5Y0y9Ia19evU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299e6ea5-1139-4c19-9b97-08de2b788bcc
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 16:43:07.7349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agIvLQ3yAtkSD+zizb9Gfa4SSMiN3TdX0u6x6qYrSeJmpNI6oJaj2babWM0sWlo4jCEN2pPHgdQB7/9bZt1UfDKsoNxQijoTdqKbbIYQxLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511240146
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=69248b20 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=BmP2q_L__UogPSo-:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=JfrnYn6hAAAA:8
 a=1F1PnYrLho5nVtqpPFYA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDE0NiBTYWx0ZWRfXxebNAS1A4aT4
 IMPlWvVdrckjCsomgHmTqmwLoZ3lW8DYIce46s7HnICiZ7w6RrLyYllnaFuh6d5elBIULdoaAUY
 znes65Do1gGKoUCd43DBe/+KW8NTUtDXlvWxwy0wgHSeUuxhOoSs8Ko1Ll6QC0QL0jyc/pYG308
 b5s4pFIAoEse/J4TR7rMVKvU4+Zxq13XBbYLFcC3CM3lhhzclpQPnEC1DG6BzSsq+BDw8Op/m0/
 ak/xJ07/CjkfdlnpP6OQjkzjrUCdfatI6XB3SvzCZIbkEQgUeS0Y9kjY++B+sztCnYsg/bgJWfI
 D1O7E+rx2DSHPH+E7phaIPRgGh7fcsOpurPpWXzshd+Zb5tYOFheQkVTMEncQZn5K3lmWdPb/MA
 gfVni49dJwzfc5lkONYNCks8lghNAw==
X-Proofpoint-ORIG-GUID: iDQM1Oc1cYC029_Mdyu5VXEf9WSGiXzs
X-Proofpoint-GUID: iDQM1Oc1cYC029_Mdyu5VXEf9WSGiXzs


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

Ok, then:

objtool: Add function to get the name of a CPU feature

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

Here is a fix. It works with gawk and mawk:

diff --git a/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
index 1b1c1d84225c2..cc4c7a3e6c2e2 100644
--- a/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
+++ b/tools/arch/x86/tools/gen-cpu-feature-names-x86.awk
@@ -12,19 +12,20 @@ BEGIN {
         print
         print "static const char *cpu_feature_names[(NCAPINTS+NBUGINTS)*32] = {"
  
-       feature_expr = "(X86_FEATURE_[A-Z0-9_]+)\\s+\\(([0-9*+ ]+)\\)"
-       debug_expr = "(X86_BUG_[A-Z0-9_]+)\\s+X86_BUG\\(([0-9*+ ]+)\\)"
+       value_expr = "\\([0-9*+ ]+\\)"
  }
  
  /^#define X86_FEATURE_/ {
-       if (match($0, feature_expr, m)) {
-               print "\t[" m[2] "] = \"" m[1] "\","
+       if (match($0, value_expr)) {
+               value = substr($0, RSTART + 1, RLENGTH - 2)
+               print "\t[" value "] = \"" $2 "\","
         }
  }
  
  /^#define X86_BUG_/ {
-       if (match($0, debug_expr, m)) {
-               print "\t[NCAPINTS*32+(" m[2] ")] = \"" m[1] "\","
+       if (match($0, value_expr)) {
+               value = substr($0, RSTART + 1, RLENGTH - 2)
+               print "\t[NCAPINTS*32+(" value ")] = \"" $2 "\","
         }
  }
  
I am going to send the updated patch.

Rgds,

alex.



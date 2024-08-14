Return-Path: <linux-tip-commits+bounces-2045-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD9A951288
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 04:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91DEB21D0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Aug 2024 02:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75D18026;
	Wed, 14 Aug 2024 02:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT99zBK5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23A2E3EB;
	Wed, 14 Aug 2024 02:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723602909; cv=fail; b=K/3MSWaGYj5nL7izBODVv2BBzd+kTg7kTbYdcgTQmx7WfIeku6JtMO+APg0kTBAhjqmDZxW2FSeku8x6Y3gOAqupvyeoYiIgCikfR10FHtJ+4O1fvFtmr/73qjultWV7OWnhwtISIY7PCtPLzKgWJQSHDnat4wTU+Z29F9BTV5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723602909; c=relaxed/simple;
	bh=zllMuR7pjdvHEL96Smf6e2NBiD6jlF6jzg/bFBTMIMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lDfJhhqzE8HGjAs78gV4lp6r7x9frQMZDQS1soffR3e3nOrQxt+tPmQIlxi0aSStD1gIBgDC5prbW/8SF332Rmm9hMRgsX/DR/P1v4D/9OrK64OYYJGEjDcacTDKmiOGmdNIj0K0/Jn8AGA1RF3jgT3Y22zTYzVRUFt408AgEhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT99zBK5; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723602908; x=1755138908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zllMuR7pjdvHEL96Smf6e2NBiD6jlF6jzg/bFBTMIMs=;
  b=YT99zBK5MWARWi5zyPWQmCdukNKOf2IX/jTlLieuIrEiTflH6KTmwVmt
   z+hrFpkS1qU+/I6KrTMS4RH95ej8g1BWA2bxnjlVdPI2yd2WeU6/pB7Tm
   TpcAV+O6RIGz+K91YxydXYw5ujNSWCf4QyAFZjsmKg04/znfRIfeBNkCT
   sBIo7B87REpNDPw3aErR5IZHxPENtKEE0066RLAZzJocNZzwb7v7NtGDu
   0458hG7zO6qcOkiPsamvPS6jNaMzGRKLqv22rvFJZlegnHNIrKLyqpqej
   qW9vRp4T1uzyTIfx2Ims0co810rrF14FaOlxJiQVyaVf3b2Br6ZoMSEaL
   g==;
X-CSE-ConnectionGUID: FsaOYD/KTxiJBLE3dKKajQ==
X-CSE-MsgGUID: Q1LEUgS7R5ukTjTdx5Pdpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21966713"
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="21966713"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 19:35:07 -0700
X-CSE-ConnectionGUID: jpTWG13cR5Gxnx7dCwCMPw==
X-CSE-MsgGUID: qxXpyUpXQVy239gJL4DvqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,287,1716274800"; 
   d="scan'208";a="63723162"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 19:35:06 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 19:35:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 19:35:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 19:35:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iST11gbpLUhJiwKaw6pkF+Sdt54r+po/wUoJJsLMZ3/WDYnHjQZtyFd2ZZeqqdEC3T4SbSv7tDJcUO5VlafbMdxpxk0vIyQrFBQ7HCLwryd2MjNxiPzapOieWqgLcg0eeP4Ay/XyYcDrFLhap5zpxOJXmZhDyWQwFLGrBnU4sx9NfOZt6gKuCtmIqOuhCH9hNnqCXFgsyyolZW2dj0v1TXBb511FQDqpv8wDN3pQJS1KRPFZteUDxJvkBGKZJTw6tpYkeqWGrz0cSRm+/1ncAROWEItIG8EkMDTpA/zwkXsCU0bGUNgIWjYgFm5ktD4TaAFFBlHsES6JExQE9sa3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IbIvQWrznJOxsZIiyPtjUEAOoveKns19Lzq6yz8Ix8=;
 b=S2qwTKLfo5TXeyixW8v3PMFpgJ6uVD7/zRUbJBcShy82RhdEMDSiH4/z4k1sSTmUQizhpLgR3gTZQA+QY3Sn2wacnW8X63fwwm4k6kUYnCbYyTvbb0GIxZri9PZ60CzPUkQiJ44A1H96i9E5ChQtjDvoKrV3YYcNNOOu7+a1WXtSya4s/fgbERCeg13uZgWbMxcGhSP1dHx5alRDgrcjeAIzoHFWipoj2G6p8RoBcHwU5NSZYKHpBbOoO/CSsd2Syn75kROFTUTjpJewSADrqfFXmVRrpKXN3vHWbxneQDM68NpH5e4ZM2kfH9Q1reAiQ7JIiCWHD5+muebcJcQE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by CY8PR11MB6842.namprd11.prod.outlook.com (2603:10b6:930:61::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.32; Wed, 14 Aug
 2024 02:34:56 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.031; Wed, 14 Aug 2024
 02:34:56 +0000
Date: Wed, 14 Aug 2024 10:35:52 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Namhyung Kim <namhyung@kernel.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<syzkaller-bugs@googlegroups.com>, <x86@kernel.org>,
	<lkft-triage@lists.linaro.org>, <dan.carpenter@linaro.org>,
	<anders.roxell@linaro.org>, <arnd@arndb.de>, Linux Kernel Functional Testing
	<lkft@linaro.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [tip: perf/core] perf: Fix event_function_call() locking
Message-ID: <ZrwYCBazVKjBni/+@xpf.sh.intel.com>
References: <Zrq4PRAVxjlnvFnb@xpf.sh.intel.com>
 <20240813151959.99058-1-naresh.kamboju@linaro.org>
 <Zrul5kzUc-5BfWcT@google.com>
 <20240813210209.GA35275@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240813210209.GA35275@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|CY8PR11MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5b3278-0a0c-4312-83be-08dcbc09af1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TK7MnW+yr1XfpKgiruCjtY+T88ZyBfz2aG5/lOTJ91zCQXLCE4FQa1fcnaIR?=
 =?us-ascii?Q?Vohxdkti/yvpLuivkydIWzMiIW/Ot+/gOVXQx6GAzXRY8CXcw/XD0qot8HJa?=
 =?us-ascii?Q?rB+0Uha/bAQ1fGGN41xRgplucJxgUvePQHC5bdeklk8+dkEUaEuJU9Mjgzym?=
 =?us-ascii?Q?R7F9Vq2SGuly9qDkie12Z+Wx4gfiC79XWUOq0ucJVib7Vybr3EOZtoo+uSwm?=
 =?us-ascii?Q?hhyuwT51ZyYOBtetoMmF2EaFeb1rNoikVbJq0hjPJ8mh5JmBWW4WFuOr+0Gy?=
 =?us-ascii?Q?p32m5+ntL75OiDFZlxpTsKe7c0yQdXzIOcso0CRBW6PUHva7/2fDC+VKn5nc?=
 =?us-ascii?Q?fIv9xpIXWMwJn8BolS3r2NV9lEecvCBAriH0jAPD1pi6Zc9UTp5g+WJM4TSr?=
 =?us-ascii?Q?IWjKhJzD8b/84hzz5e5WKueblt7iR8hUrAeOtoFhg21waArx+xmSAAdDnyb7?=
 =?us-ascii?Q?n9IQvNWfgF1Phkyav7BBASEJ/sCv02u5YkMBmGf629c3vZLIL4dpDpDXuwYL?=
 =?us-ascii?Q?g5+/vOs57ckSNu3Sas2VBiJ7oOsuymmGGzN2YXdceTKIWSmzk+KGr/2Nt45o?=
 =?us-ascii?Q?O12kOIkq8cwdTzQxrvnsMe6woK1145ieppUhc4DmjmgoN3n5tOmNkkmG2t0V?=
 =?us-ascii?Q?sGneORqPp7WWy4pNe+rPXduf+C+8nhSL0VszHBQfRvgux6YxEnMeg73DAgNg?=
 =?us-ascii?Q?0ob2Kn2CTlw14eVVatnbh7YcjKSlZIIFIwMWgc7S/NXncKc2F3bXaWZA+2cL?=
 =?us-ascii?Q?Rolx1qwr+oooCG5cnZfqv2chWtu6BUJi0HykWolgph+kdslYUICTRmcy3+zt?=
 =?us-ascii?Q?I3a6PbpJTG0fjm1mwVZ15eIor57xh+qLqz98iP5sXHOUEhf2VBR50kjoFcFk?=
 =?us-ascii?Q?OauZKuCc6mpK8LZPA6S+EwmjnZVyqhw3GlHvaV5kFwvwu98lDp7X9SEDGr7y?=
 =?us-ascii?Q?9Pa9w2KE56i+mRBqGRCQhc+TUMZgmIMRp9m7HyqKNZogaYUNbtcSGIbzUAPZ?=
 =?us-ascii?Q?3YsGM/6ytIxBZFLWWg00M2GYCMAXSZebgqYQPgoFfaonWmHlWlCedwHxnaax?=
 =?us-ascii?Q?Xn6x0ozHcqZFqj/hmCNLP5O6c50uk1L52mN1+SZwBdNYm76j7Gl/bwpquX3X?=
 =?us-ascii?Q?vnOiEiwvBTbh6YKt3A4KtnY3avmQz9Xe6lfxOofSV1q5leC8v/xp0aktfAZT?=
 =?us-ascii?Q?ERUyiWlaXtHrqQhIFvB/3FsTTpWWFvLqGJnw4IXm0S3JoeLfIMR5hGKS/w0O?=
 =?us-ascii?Q?CltEU8yp1fsCvRGbREuAfhCvV97LhzeMYk1q2FY9HA/DkwuFa/dK0EwufJtp?=
 =?us-ascii?Q?/a22W9IaPoZ14H/3KgF5iOB2RkhPj/u+ZHHEUsEY+yyUYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ExG2JRp2Vn2YzYUG/NhagFl2oaXRePrHYu8z2WzZVXt8h/1UI7Ngv4H0azyK?=
 =?us-ascii?Q?UbjY3GVYXBm/TP5uHMhgAGIDZsaz5nPF0Bj++3os8OZzO+lQqeCyHXzAoikR?=
 =?us-ascii?Q?WzIxCT7JWXiYZQ4WiSSXjKtc34iANBWxr9J9EGJmR1UcoKkfjWrFV0wQQEe9?=
 =?us-ascii?Q?8BnpdkeCLDEXKvSPsUrB2oLEUbXqObPFecuigVeyqnN4D+Ckn9C3uGoSKuwQ?=
 =?us-ascii?Q?pGglomdcaTnzDVwPobAGVOkoQI77dPx0PXeadA3l7v/CGmdM1RRawl/7CVfN?=
 =?us-ascii?Q?5CVFpjqMi7l1sUZRf23wzybom4EA2nw9UhimobCnSGPPSgdpD3rH/FaZ5gIz?=
 =?us-ascii?Q?tSuz4PCyIaafWQ3ojSvnOwqurQ4W+MPlMbrEsawR/QaX2k/07Y8Nk10IGXM+?=
 =?us-ascii?Q?QzaLJlM2+DyeaL2+ceCeZ7ABvmMbasmNmuiy62cDLn9bqVsiQ3ujNZ9FlHU8?=
 =?us-ascii?Q?ktrc0kucNJIEfvrRo+D/TJbjUEiMh4Q8/UJ16WknnqdAQzZmzDksCAOj3xJ0?=
 =?us-ascii?Q?r9Bw7S16I51KLdua9W1igcYM/e6bA8kCTy0KHk3A5h/EQea0yx/K9GiJ+RU0?=
 =?us-ascii?Q?DDlQF8VIi1Ss5l1CJqsGYg6mdyOdvV5SiJN+C4Ehu8GJH7sILwEuwjSWGnid?=
 =?us-ascii?Q?qMelhjCdgPCQu7zPT/ORGAN0Pdas5Ok5Ar34noSJkvRqrpZOfiBcLvwvOU5W?=
 =?us-ascii?Q?mu4t8kB8Rkle9CVta5DMjk2JM95FzgOVq7nqTMMebtybkk/Bk7ZuWD5YnLCp?=
 =?us-ascii?Q?5oGNWmJ7lAxUbXBjOMe+cmp2Vg/HdnRC/8hS32rPMuBNLxpPDdgx64xHG1ZW?=
 =?us-ascii?Q?TQ76nQywprFIRCn42EedK/xVnVuTj3UhxbunFTlZDtHiBWsljax4z6rDphkX?=
 =?us-ascii?Q?cRyChtz5qSYZjhYP38KQ90XNQKPmD5g91gPXDV92StAKxOiELdNGpIz/3ypA?=
 =?us-ascii?Q?HJRIvorkzzKhCMlJi4Hzocsebg1y4QBh00Pdf1ptS47okqffnPQGt2nnak8B?=
 =?us-ascii?Q?Cmgj+92Z/OOs9HXK8HqzWiQI2ebsUO9jzFyB6EGKFBMIn+xg1YS8SAZswSdc?=
 =?us-ascii?Q?b5gG2m8lKWVLJ4YOxPFkSkAC48lLoQlp7AdMoJnKiXGyusHUXvTi/p+jyido?=
 =?us-ascii?Q?aqfOpYxGwWq47NrEQfhecQoycJxJP2QTl1QpfpuseWXkb01Dh5eAaINsCBVX?=
 =?us-ascii?Q?y82wQNcAhxIzC5yU1Neq+eZPYbZleTeAomhjunsYTl9cV0thskUT9XUbLL2+?=
 =?us-ascii?Q?H7AgFVFdcSQwDsiqwqDNGRfOCj7gV26mnL/zIticDEvPq+djN3gh5AuN3bHW?=
 =?us-ascii?Q?iV8QYjCYmGzOp1e31vga0qFczTIsJJfpWjv9uDLwTqW8uV+I/oYdbXTGnlZm?=
 =?us-ascii?Q?4YD58N5vN6ocvn2rN2jNN1izpkJDZpY3e1+ccc6yds1GbDyCFh48Yv3nUCM1?=
 =?us-ascii?Q?4ARfofhbcZ2RdtqHu2P9iO7+b7T5LVJRmobBzOwGpkqlBWO/zs4hYRNfV8Q7?=
 =?us-ascii?Q?E0CUwoLTYnw8/+W2LryIg+uGdTRAPO00z3mDFIcQTgyEs2uEnIbVsV4AAnYl?=
 =?us-ascii?Q?8rIFn6YHNzZ00Gg6w6khwagCkF3ildoU5EyC8k3d?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5b3278-0a0c-4312-83be-08dcbc09af1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 02:34:55.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfHDjHpCLsWSgpf/QJyHRDtlJseiK3P3H4rKlm+ZnjHogZzdv4YP3Ykk83ciTkOzyuN2nPA/DAXFB3lJiez5xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6842
X-OriginatorOrg: intel.com

Hi Peter and Kim,

I tested this patch on top of 6.11.0-rc3-next-20240812.
This issue can not be reproduced in syzkaller reproducer.

Best Regards,
Thanks!

On 2024-08-13 at 23:02:09 +0200, Peter Zijlstra wrote:
> On Tue, Aug 13, 2024 at 11:28:54AM -0700, Namhyung Kim wrote:
> 
> Duh, yeah.
> 
> > ---
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 9893ba5e98aa..85204c2376fa 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -298,13 +298,14 @@ static int event_function(void *info)
> >  static void event_function_call(struct perf_event *event, event_f func, void *data)
> >  {
> >  	struct perf_event_context *ctx = event->ctx;
> > -	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
> > +	struct perf_cpu_context *cpuctx;
> >  	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
> >  	struct event_function_struct efs = {
> >  		.event = event,
> >  		.func = func,
> >  		.data = data,
> >  	};
> > +	unsigned long flags;
> >  
> >  	if (!event->parent) {
> >  		/*
> > @@ -327,22 +328,27 @@ static void event_function_call(struct perf_event *event, event_f func, void *da
> >  	if (!task_function_call(task, event_function, &efs))
> >  		return;
> >  
> > +	local_irq_save(flags);
> 
> This can just be local_irq_disable() though, seeing how the fingered
> commit replaced raw_spin_lock_irq().
> 
> I'll queue the below...
> 
> ---
> Subject: perf: Really fix event_function_call() locking
> From: Namhyung Kim <namhyung@kernel.org>
> Date: Tue Aug 13 22:55:11 CEST 2024
> 
> Commit 558abc7e3f89 ("perf: Fix event_function_call() locking") lost
> IRQ disabling by mistake.
> 
> Fixes: 558abc7e3f89 ("perf: Fix event_function_call() locking")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -298,8 +298,8 @@ static int event_function(void *info)
>  static void event_function_call(struct perf_event *event, event_f func, void *data)
>  {
>  	struct perf_event_context *ctx = event->ctx;
> -	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>  	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
> +	struct perf_cpu_context *cpuctx;
>  	struct event_function_struct efs = {
>  		.event = event,
>  		.func = func,
> @@ -327,22 +327,25 @@ static void event_function_call(struct p
>  	if (!task_function_call(task, event_function, &efs))
>  		return;
>  
> +	local_irq_disable();
> +	cpuctx = this_cpu_ptr(&perf_cpu_context);
>  	perf_ctx_lock(cpuctx, ctx);
>  	/*
>  	 * Reload the task pointer, it might have been changed by
>  	 * a concurrent perf_event_context_sched_out().
>  	 */
>  	task = ctx->task;
> -	if (task == TASK_TOMBSTONE) {
> -		perf_ctx_unlock(cpuctx, ctx);
> -		return;
> -	}
> +	if (task == TASK_TOMBSTONE)
> +		goto unlock;
>  	if (ctx->is_active) {
>  		perf_ctx_unlock(cpuctx, ctx);
> +		local_irq_enable();
>  		goto again;
>  	}
>  	func(event, NULL, ctx, data);
> +unlock:
>  	perf_ctx_unlock(cpuctx, ctx);
> +	local_irq_enable();
>  }
>  
>  /*


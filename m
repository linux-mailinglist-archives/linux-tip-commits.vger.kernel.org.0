Return-Path: <linux-tip-commits+bounces-2032-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99994FB21
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 03:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68F69B21B88
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 01:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE994C74;
	Tue, 13 Aug 2024 01:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZsmuHQx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA46AAD;
	Tue, 13 Aug 2024 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723512850; cv=fail; b=UWUtdQBiaPjdYqK7gP8Ho+qYWctNcnk212dZK9TEAr/TW52le43aTZecdDR1w/V9L6KhLmae5+BQq1ZU/IX+AhvClxyjcgDzHhcdyhCXDN4vuD+z92ifGpraJqkfkGnFp8uKkNPopVjfDX47PvC4DpjEyTKQ1lnL41p8TZ2R9qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723512850; c=relaxed/simple;
	bh=TCywuFd2zyJfTTH8MCyUhHGtOIb2sdBtAKMDfEH7a4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kPT7zp7oUobVW7fOcEUp6r6yK45yz5Qad+xRUJe5bJw/4Sv5A6/i+WXcMqkN33EJ3g/QCsasnJpLC0GaeHH0tlE7k2ndmyGIzKwik7LU71uiUxUrYLuEk+UVaQRYG4vr11dRND6SO09Te06nedl1QI8K2FN5durBkRcab6HudA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZsmuHQx; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723512848; x=1755048848;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TCywuFd2zyJfTTH8MCyUhHGtOIb2sdBtAKMDfEH7a4g=;
  b=iZsmuHQxxdKTUaOexgl6RheB0WGMcOVIyj9p5sTtnB5qycATABNvqG9O
   N7AyQ2JPlW98qYXOWoxt2zDFwkWiApg9JmCODRf8tVmZrSQMg/NCPgA2k
   Q1WSe8ZulIvzBo9EpCTY8Wvk5ImT7YG8B34KqUigKU4X14OQeL7iM6qd2
   O0SIertWhR5hbrAhWnkwyJITcFVxGRUNC53+Fb2gbwHXXs5/8boHJX8OZ
   kNTGDt4HLyBvIQxWuNmALQUMLEGqmkVQ1TGyZJpiHV+gjf2LwP3PjtZLI
   30W3EsOyqUJFPTulvNkCl5hve1m8zG0TstL42m36OYvqTh6O5PeI8h1oi
   w==;
X-CSE-ConnectionGUID: kJQUrEeUSdepdcZq1d/YGQ==
X-CSE-MsgGUID: jmpVOD6xRA2WDXft4kTmPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39102466"
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="39102466"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 18:34:07 -0700
X-CSE-ConnectionGUID: MfL1f3qmRJ6NOdiAL6h5Pg==
X-CSE-MsgGUID: x0TVyVoBTE6stYddEdmquQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,284,1716274800"; 
   d="scan'208";a="59057283"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Aug 2024 18:34:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 12 Aug 2024 18:34:05 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 Aug 2024 18:34:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 18:34:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XlNI4lGMYJvc5CLYaHP11K+bXahPZz0DZQdvJUZqsGmleenlGIFYNggcgQfF/TltaP/8snzofYSgPjGHYIrIfmlSM9HQWZ5cLIFz9mKXIM1vnoQEjhZ+YLWcCWTNe07eJhuZ84fsnThTVSSeilXeKcvElpwoH1gl5tmMBaTrIdcA0PlJqzlj5vLOymYb1gWEwrx+snAItkgkg/r5kd96CqV55ioKObhdwWLUREvL7njESQ1rWIdteuWMAK7TieSr+85558/kZaJ/Sisi6/F5lI+M53FW9nGfubtCFXFlsrQ2H/bDCh7KlKy/1YPILAa3Smsg4GxkZQB6zNTYbO1zjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlH7LZCpeGKAz9fyupX9Jc/SLE3qI2R+I3vxUDPejVA=;
 b=il6XTbi1PWq0pdJmhsw1N9z2jGcgas5qu62amHyBK4oQzkA4t7rbmLf6uiBoDD7Emwv9qrdxVrhSYmv0zSSmDoNXx1SxWXmQYl9X/TKhzAZA7+qO7dHXWKPMNZzg3j+kNADh3SKficMQduuspZSmR1y6QctWaVaHSoEs1OV/dX9PWPsDW521pSa4pVqcIz9IVPVXMWNbGuHKbpBboKGjVwOsX89Z67WwQMySMBs2M1qU/F2i8I5NC6MoVKasa8Wk3M/1clb7yMwo7Ixwb0fzniLgGQdewBITkS8WpXauCS/WtRyBS98u/bq7RiSQ3eifDsjX6v7MkXb6Km1NvFwC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by SJ0PR11MB4927.namprd11.prod.outlook.com (2603:10b6:a03:2d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 13 Aug
 2024 01:33:58 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 01:33:57 +0000
Date: Tue, 13 Aug 2024 09:34:53 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <linux-kernel@vger.kernel.org>
CC: <linux-tip-commits@vger.kernel.org>, "Peter Zijlstra (Intel)"
	<peterz@infradead.org>, Kan Liang <kan.liang@linux.intel.com>, Namhyung Kim
	<namhyung@kernel.org>, <x86@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [tip: perf/core] perf: Fix event_function_call() locking
Message-ID: <Zrq4PRAVxjlnvFnb@xpf.sh.intel.com>
References: <20240807115550.138301094@infradead.org>
 <172311312801.2215.8572777928731385731.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <172311312801.2215.8572777928731385731.tip-bot2@tip-bot2>
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|SJ0PR11MB4927:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c92e34-293c-4310-578d-08dcbb38002d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RQApf6OMBNi4+zDItpON+1ZAza6W1hwwDIzAjedN63R6M61SHIdWuNHkdSAs?=
 =?us-ascii?Q?NgGJAgm77xJyCl52DXsUzn1td5d+0g54siSkfD33gIYq6Hk4jqX/lP/bvJzs?=
 =?us-ascii?Q?17s6Y5KF3b4+pVLr5Z3EetrJUxLyyp2dGdw9iW02MQv//DSiR1BtDrEbrifJ?=
 =?us-ascii?Q?JsdXJAnXi3IcoRen0Xs9HD2EKsYHTaDM5FcMMLdgC+mrOXwvdM80fpD4QZKq?=
 =?us-ascii?Q?FX+orGKBe0PeuA8W5M3qfBkn6t+dWnarGfLZvrYvyxC8ahQBxEmZIUOaJL9K?=
 =?us-ascii?Q?js3R/3LI9R/bZvfIK7rzKdJzVn3RTJXd3PC7rdS6Hmyhlah1kuOwiOa0Mgcp?=
 =?us-ascii?Q?gfyJt3XSRRv0xNSO46wj6euP3rfIr48Bik3k5kSuntbvzDHwc+f11XA4ctb6?=
 =?us-ascii?Q?xZklaNKCcyzFyOTQ12zr68lU/wZ7yOsaijYt0lUakQ2vKh5kDUM/FlNOzjSo?=
 =?us-ascii?Q?YO/cHgOmaTvbMWbLxB0bWW3GDz6t2RVOKpGN+9J3A+soSuaaUVs8TIg2RxOj?=
 =?us-ascii?Q?zEk8TL7UwRH6wJI5p7DFBijAyQcJHBEXtL+8vbraLtpN0kNPhc7c8T3debC3?=
 =?us-ascii?Q?C9q3iOS5mvMprtUjgowZaGHkgT5Q20i1zK5ZseQk4IlFL7xgZP2ayZ63b1Pz?=
 =?us-ascii?Q?4eaM9A/mIGd7TFWZnZeIyVB6Yg+L236YqLX1oa+DV3hzaVAUEEEcoAkfnUDS?=
 =?us-ascii?Q?LceTsBrGS1Uvt1uhwadsfCMlPFEf7rQgH+tkQRrqFENHAnlz8o/MiOiJA51u?=
 =?us-ascii?Q?OX+cL6ywDp3eNJvhoVnsyjDJWT0SiAH3275J25D+/xQtVsF32i++hnQvX4UJ?=
 =?us-ascii?Q?GDs77hr6G0rUheDyBsAidMwBUJh/OXInyh2aW8MIMHfrzHq0dSlY5jUSSDpC?=
 =?us-ascii?Q?2DWqVMyp6nZk6h5H8OKFtpDJObXFXhDpeXVe16OWfB1Mbq2W7rdK5gRTGzVn?=
 =?us-ascii?Q?vdzySh6Q0KDhLArmtwcBWkGAnk0gezr93eO5F1F1O0daslPfE8jZCpdhJXaN?=
 =?us-ascii?Q?DeJp/RcWULCDRXvC2GpNuifxot7gAQQO038ePOjaoDsuZPDNroW708/zGsMl?=
 =?us-ascii?Q?hJR/fOQm8ddn8laeoaKqhJKMyGkPMtPTXJypDBeJD+5GuLdj5qYQ8QaPGyz8?=
 =?us-ascii?Q?s/Vy962r4nui3f9YEP62M5SbrPvjymo2ev3ke5DIEp9wPskSKDzplJlthgrU?=
 =?us-ascii?Q?XER5L3EVKgcJCy4viKx31c8o4zoVUgbmASkIeTFpK3Mj2pQQRAOcLcEMAbLS?=
 =?us-ascii?Q?swx4e9rfLg0ZuVQrDD7cEEqFnrdyCzAa3SUgrOQMF1f8mJliZ38HqiYOI8wR?=
 =?us-ascii?Q?ydM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JaTvrVjQcM3z2xLeadRpj5qDM32oaZ7jftTONUqgJlSdB6j40BIWsDZhu19O?=
 =?us-ascii?Q?YgnLWzSgKLtral5noH4WjMPFf1LYoOGz89j1uvhCj1ntOOQxefHJ3qpV6m56?=
 =?us-ascii?Q?yEvfyi/q0Cfn3BY+3mRECmmS0a0HEj0xxOyyhYccRPHvmLyp+0WP71u1fDVa?=
 =?us-ascii?Q?nA3fSlh0fXknIjwCRZ6i2yc5YXhXihFkb7csXugBXCm6Mb1oax4c66NWbIH5?=
 =?us-ascii?Q?V8iTdDXhXmtOKsO/qE9u+CyILn7UbtnQ1ggmP1JiF52wrD0soQMeEvEfwvz+?=
 =?us-ascii?Q?czRZ3ee7xQwFztZZCD1VVXcjqGOLthtlMVLYG9i9IZDZnvJm2xDt8yCAedx7?=
 =?us-ascii?Q?JB1cQOfoj3mIuljEy3tRRQqvn5RhI1EzxTXXxdGEXlzQMwBbZQ3DlE2v2QI0?=
 =?us-ascii?Q?+AfktEio3vCiUtCkNXWgho0sjxZHqr2s9Ics2mpcSuhOxv8NBAs6Vgq6VbMb?=
 =?us-ascii?Q?tQkUNXBXyFqgg+naOXLabz7KkQyuz6Q9ln/YMlX9mG8u9uW6rJv7nX5OVr/g?=
 =?us-ascii?Q?wq4bHf+tNASnbuVblqkMsTrJIsKV41PD9Imp/XXrqqz0rh7w6RKoHsR1W58Y?=
 =?us-ascii?Q?lx5RqRL+NULR0EtumfYzWwSrjxVeoXDOLOHO4UWCniSWkihQE4D22/1JLD81?=
 =?us-ascii?Q?+tjICzdyp4d1mFZpOCqILCbhkrAEeEwL/Ddj5nrSzkrexuZ5gcFeL5J1YuJJ?=
 =?us-ascii?Q?XmtTMwWKfMo8STuLoYIAS/Mn0UHZWE9Ar1KeIuaF05s5BdY0eaSvScC4Np4B?=
 =?us-ascii?Q?OTHDUO7ISKhevCeuuXGznivUezgDU01BefUUTet674mvN/pko7hKW1RrbA0B?=
 =?us-ascii?Q?UfIum6GfRwDD4Tt2JGDffeSdKF1zfoUyth/K7ibIk1DlVv4j3KvNSp913Na1?=
 =?us-ascii?Q?uAWAe+vvusSa6QYyyE/CxUkRLlFuaM+KCuObVbMaWvFD5lZztFHb6yhTjTWZ?=
 =?us-ascii?Q?tpicV4mXlPhSbRPlbbdmswm4e4HwfBUSJQWumIORVJuXobwxHBWExZBWqX5z?=
 =?us-ascii?Q?XTsjrkp6tgZeYnVXTvKIRFq33yDpo4OJVCyUicK058rzoa80iMkuLPuPe3zO?=
 =?us-ascii?Q?aGRU4AqWKQnBd8MygRQ0tiRXkBRBzqII3ZjjC1qaTWtbWzmumSe5RwpYfxec?=
 =?us-ascii?Q?LOfb2RC9tadQrddBJzPrCHnvKi9+daR/T5tAGBaKb8ZldpueFg2Dp8X5ALqW?=
 =?us-ascii?Q?PTF7hfpFVcppBJM73LQUm8m1NFjV1Ti0TaRBdlsZJg3DYFLrKkiC1ShLTGYu?=
 =?us-ascii?Q?V5FLIS+JJMYLZY1xIZm0F8R8V+T50pLMFQoLT3zfJnOC9GvSeesJBPmbS+fc?=
 =?us-ascii?Q?HBQLcysaJfvlOFHlVNX0Xka96spDbdDmsOPAKWUAd+vIu/nACdoSGdSp8ryv?=
 =?us-ascii?Q?yDDl7fK9ltoJVbHkIA/DZ+xceqMLyt2G6OwfO78E75pUfg6RfGe286S0+IA2?=
 =?us-ascii?Q?woxWqcug4GwGcLV6NuXW/xBbiH2hH5n2wqcnizM6ZZLqfgtnvm4JjoXOcv7d?=
 =?us-ascii?Q?ue3XVkzryRN4e/wSiOA5Hgot6TDhnDKfTmQ3rM/wBVLaXAZSjJNqxCWMHORw?=
 =?us-ascii?Q?XvYRHCUmrGg3/gVgFj4cu/PeuOJLNsSZZhoW/ena?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c92e34-293c-4310-578d-08dcbb38002d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 01:33:57.7476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1IoYh1SYClIutGRCmP5HlBkzcQ6Wq1cdu7qU4N1jSQwSoerfrcwKK+3lf9P312+MkOsTas5i4FvSV1W9nRupg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4927
X-OriginatorOrg: intel.com

Hi Peter and perf experts,

There is "BUG: using smp_processor_id() in preemptible code in
event_function_call" in v6.11-rc3 Intel internal with linux-next patches in
syzkaller testing.
And this issue was reproduced in next-20240812 also.

Bisected and found related commit in Intel internal repo:
558abc7e3f89 perf: Fix event_function_call() locking

After revert above commit on top of Intel internal kernel, this issue
was gone.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240812_194918_event_function_call
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240812_194918_event_function_call/repro.c
Syzkaller repro syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240812_194918_event_function_call/repro.prog
Syzkaller analysis report: https://github.com/xupengfe/syzkaller_logs/blob/main/240812_194918_event_function_call/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240812_194918_event_function_call/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240812_194918_event_function_call/bisect_info.log
Issue bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240812_194918_event_function_call/bzImage_dcdef334e8852ca433e908db67744965101f3fc1.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240812_194918_event_function_call/dcdef334e8852ca433e908db67744965101f3fc1_dmesg.log

"
[   17.071069] BUG: using smp_processor_id() in preemptible [00000000] code: repro/726
[   17.071875] caller is debug_smp_processor_id+0x20/0x30
[   17.072369] CPU: 0 UID: 0 PID: 726 Comm: repro Not tainted 6.11.0-rc3-next-20240812-dcdef334e885+ #1
[   17.073225] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.074205] Call Trace:
[   17.074436]  <TASK>
[   17.074646]  dump_stack_lvl+0x121/0x150
[   17.075005]  dump_stack+0x19/0x20
[   17.075313]  check_preemption_disabled+0x168/0x180
[   17.075753]  debug_smp_processor_id+0x20/0x30
[   17.076156]  event_function_call+0xd7/0x5c0
[   17.076520]  ? __pfx___perf_remove_from_context+0x10/0x10
[   17.076986]  ? __this_cpu_preempt_check+0x21/0x30
[   17.077404]  ? __pfx_event_function_call+0x10/0x10
[   17.077850]  ? __this_cpu_preempt_check+0x21/0x30
[   17.078276]  ? _raw_spin_unlock_irq+0x2c/0x60
[   17.078681]  ? lockdep_hardirqs_on+0x89/0x110
[   17.079084]  perf_remove_from_context+0xf7/0x1d0
[   17.079506]  perf_event_release_kernel+0x186/0x870
[   17.079944]  ? lock_is_held_type+0xef/0x150
[   17.080326]  ? locks_remove_file+0x3bb/0x5e0
[   17.080727]  ? __pfx_perf_event_release_kernel+0x10/0x10
[   17.081202]  ? __this_cpu_preempt_check+0x21/0x30
[   17.081634]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   17.082116]  ? evm_file_release+0x193/0x1f0
[   17.082502]  ? __pfx_perf_release+0x10/0x10
[   17.082880]  perf_release+0x40/0x60
[   17.083203]  __fput+0x426/0xbc0
[   17.083509]  ____fput+0x1f/0x30
[   17.083806]  task_work_run+0x19c/0x2b0
[   17.084159]  ? __pfx_task_work_run+0x10/0x10
[   17.084553]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   17.085036]  ? switch_task_namespaces+0xc6/0x110
[   17.085463]  do_exit+0xb19/0x2aa0
[   17.085778]  ? lock_release+0x441/0x870
[   17.086138]  ? __pfx_do_exit+0x10/0x10
[   17.086485]  ? __this_cpu_preempt_check+0x21/0x30
[   17.087007]  ? _raw_spin_unlock_irq+0x2c/0x60
[   17.087219]  ? lockdep_hardirqs_on+0x89/0x110
[   17.087426]  do_group_exit+0xe4/0x2c0
[   17.087607]  __x64_sys_exit_group+0x4d/0x60
[   17.087799]  x64_sys_call+0x20c4/0x20d0
[   17.087974]  do_syscall_64+0x6d/0x140
[   17.088144]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.088374] RIP: 0033:0x7f6c5a518a4d
[   17.088541] Code: Unable to access opcode bytes at 0x7f6c5a518a23.
[   17.088832] RSP: 002b:00007fffca44fe68 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   17.089166] RAX: ffffffffffffffda RBX: 00007f6c5a5f69e0 RCX: 00007f6c5a518a4d
[   17.089476] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 0000000000000000
[   17.089790] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   17.090100] R10: 00007fffca44fd10 R11: 0000000000000246 R12: 00007f6c5a5f69e0
[   17.090411] R13: 00007f6c5a5fbf00 R14: 0000000000000001 R15: 00007f6c5a5fbee8
[   17.090740]  </TASK>
[   17.162307] BUG: using smp_processor_id() in preemptible [00000000] code: repro/727
[   17.163284] caller is debug_smp_processor_id+0x20/0x30
[   17.163765] CPU: 0 UID: 0 PID: 727 Comm: repro Not tainted 6.11.0-rc3-next-20240812-dcdef334e885+ #1
[   17.164571] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   17.165606] Call Trace:
[   17.165840]  <TASK>
[   17.166045]  dump_stack_lvl+0x121/0x150
[   17.166407]  dump_stack+0x19/0x20
[   17.166732]  check_preemption_disabled+0x168/0x180
[   17.166944]  debug_smp_processor_id+0x20/0x30
[   17.167153]  event_function_call+0xd7/0x5c0
[   17.167355]  ? __pfx___perf_remove_from_context+0x10/0x10
[   17.167611]  ? __this_cpu_preempt_check+0x21/0x30
[   17.167835]  ? __pfx_event_function_call+0x10/0x10
[   17.168072]  ? __this_cpu_preempt_check+0x21/0x30
[   17.168297]  ? _raw_spin_unlock_irq+0x2c/0x60
[   17.168505]  ? lockdep_hardirqs_on+0x89/0x110
[   17.168718]  perf_remove_from_context+0xf7/0x1d0
[   17.168939]  perf_event_release_kernel+0x186/0x870
[   17.169164]  ? lock_is_held_type+0xef/0x150
[   17.169362]  ? locks_remove_file+0x3bb/0x5e0
[   17.169546]  ? __pfx_perf_event_release_kernel+0x10/0x10
[   17.169791]  ? __this_cpu_preempt_check+0x21/0x30
[   17.169994]  ? __sanitizer_cov_trace_const_cmp2+0x1c/0x30
[   17.170219]  ? evm_file_release+0x193/0x1f0
[   17.170421]  ? __pfx_perf_release+0x10/0x10
[   17.170620]  perf_release+0x40/0x60
[   17.170790]  __fput+0x426/0xbc0
[   17.170938]  ____fput+0x1f/0x30
[   17.171082]  task_work_run+0x19c/0x2b0
[   17.171271]  ? __pfx_task_work_run+0x10/0x10
[   17.171478]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   17.171732]  ? switch_task_namespaces+0xc6/0x110
[   17.171957]  do_exit+0xb19/0x2aa0
[   17.172122]  ? lock_release+0x441/0x870
[   17.172314]  ? __pfx_do_exit+0x10/0x10
[   17.172476]  ? __this_cpu_preempt_check+0x21/0x30
[   17.172700]  ? _raw_spin_unlock_irq+0x2c/0x60
[   17.172910]  ? lockdep_hardirqs_on+0x89/0x110
[   17.173126]  do_group_exit+0xe4/0x2c0
[   17.173307]  __x64_sys_exit_group+0x4d/0x60
[   17.173509]  x64_sys_call+0x20c4/0x20d0
[   17.173679]  do_syscall_64+0x6d/0x140
[   17.173854]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   17.174091] RIP: 0033:0x7fc803b18a4d
[   17.174245] Code: Unable to access opcode bytes at 0x7fc803b18a23.
[   17.174522] RSP: 002b:00007ffd949207a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
[   17.174892] RAX: ffffffffffffffda RBX: 00007fc803bf69e0 RCX: 00007fc803b18a4d
[   17.175208] RDX: 00000000000000e7 RSI: ffffffffffffff80 RDI: 0000000000000000
[   17.175526] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000020
[   17.175849] R10: 00007ffd94920650 R11: 0000000000000246 R12: 00007fc803bf69e0
[   17.176170] R13: 00007fc803bfbf00 R14: 0000000000000001 R15: 00007fc803bfbee8
[   17.176508]  </TASK>
"

I hope it's helpful.

Thanks!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!


On 2024-08-08 at 10:32:08 -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the perf/core branch of tip:
> 
> Commit-ID:     558abc7e3f895049faa46b08656be4c60dc6e9fd
> Gitweb:        https://git.kernel.org/tip/558abc7e3f895049faa46b08656be4c60dc6e9fd
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Wed, 07 Aug 2024 13:29:27 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 08 Aug 2024 12:27:31 +02:00
> 
> perf: Fix event_function_call() locking
> 
> All the event_function/@func call context already uses perf_ctx_lock()
> except for the !ctx->is_active case. Make it all consistent.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/r/20240807115550.138301094@infradead.org
> ---
>  kernel/events/core.c |  9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index eb03c9a..ab49dea 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -263,6 +263,7 @@ unlock:
>  static void event_function_call(struct perf_event *event, event_f func, void *data)
>  {
>  	struct perf_event_context *ctx = event->ctx;
> +	struct perf_cpu_context *cpuctx = this_cpu_ptr(&perf_cpu_context);
>  	struct task_struct *task = READ_ONCE(ctx->task); /* verified in event_function */
>  	struct event_function_struct efs = {
>  		.event = event,
> @@ -291,22 +292,22 @@ again:
>  	if (!task_function_call(task, event_function, &efs))
>  		return;
>  
> -	raw_spin_lock_irq(&ctx->lock);
> +	perf_ctx_lock(cpuctx, ctx);
>  	/*
>  	 * Reload the task pointer, it might have been changed by
>  	 * a concurrent perf_event_context_sched_out().
>  	 */
>  	task = ctx->task;
>  	if (task == TASK_TOMBSTONE) {
> -		raw_spin_unlock_irq(&ctx->lock);
> +		perf_ctx_unlock(cpuctx, ctx);
>  		return;
>  	}
>  	if (ctx->is_active) {
> -		raw_spin_unlock_irq(&ctx->lock);
> +		perf_ctx_unlock(cpuctx, ctx);
>  		goto again;
>  	}
>  	func(event, NULL, ctx, data);
> -	raw_spin_unlock_irq(&ctx->lock);
> +	perf_ctx_unlock(cpuctx, ctx);
>  }
>  
>  /*


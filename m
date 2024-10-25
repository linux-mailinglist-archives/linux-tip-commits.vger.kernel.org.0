Return-Path: <linux-tip-commits+bounces-2546-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C799B0609
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B701C20CCA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Oct 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A932022EC;
	Fri, 25 Oct 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tlq5RzN3"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290B57082E;
	Fri, 25 Oct 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867422; cv=fail; b=YfvtlcuE0ffMoWA1abM6X1AI3bsCwphKwMNbahQpsxYilID8QDe4XhwYUuIcQhGCP05MBMe/fkjFXZjHxx/dtNY5e2QA22eoA1ArFQURPriFA6O15uNmT1SSv+5ZiGu/oA/02BV7jV/nKsK04Bf77pzlTgqqkYY0vi+LwmQp3s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867422; c=relaxed/simple;
	bh=mUNGL8BJyI3FNG1G7KSKYcbQfos9HF8r0YY+7nXmveg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KetbxcPl3sGU6kRtKtdF4F2NisruADJDYSYUrg7fQrprmK8rbVs+DJhDEWvnIFusv6lZNh79bAxnN535sDEkvuWcnt1sAA7HumINuKiH7DWgVFzj3Fp1mMUsNDZxo3Rco0V7CoSxkLfPVd5xr3ycKN9qV/5e8Nl3GENuxEPoY1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tlq5RzN3; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjfVerVvMJt7q4DDqASs09dSVV1lwD+Q2gvQG6yzDgLzw5zXN+nFrptY4IgxCF+jgYlBxZfVX0yhMbyuzg5A8sMTg8qIjtjObtz+EekFf9aFw4PyDphqW8iyA3cn6ABms2fj+zkijBWWaj2jzxqOFl4s+mBtdEUJqFTe3e3ltK7MFAkfJif3OsaCwBwxDgIBVPcK9/8qwSagN6LvCimJ23Kl2hA3zCWN/jM7hKGCVP+qLpQchtXVhG6EiJfM3vSSWED9un7hKgup1dEPgspLS8FijByJhSzESRadGFoj5ZBT5s0TwmStls4RFBR5T1EE5u5Q69Gku6vIETE05mv7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YBQBTXoQR+Slp+ndl364BoEy8dAHEAEKeanhTTnaxI=;
 b=TIxL58osya1r174sUCRy6vR4MapoG2lz0ixRiSKsXp66MIu1usG0x8A7Y36bIUNtPKL3dWO401/iuO9rcg26meQEyDhtYdzUaP23UZU+RR5q/b3p5tpJqrCwgUhUIxyPfDtqsx6wSyIxxulPgw9xLq7x53w1FUwn8FzIM1hnzywu7a9J9BJlkHKlFiDRsHmeEgEjGcvPE4pOhyogu0vT8IwvOWy+EJSgB7Tkm+KKoEa/BtfrnOJKpvwETo6VwLTZTYF4xa30lCtQ5ojStUhgmUu53sw8TlcCLSxnR81Hw/XZr6BQFongb2nmDmOV7kGM1gXR4A1OIJF0h4uihzSI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YBQBTXoQR+Slp+ndl364BoEy8dAHEAEKeanhTTnaxI=;
 b=tlq5RzN31IrtQRMYJFSnmel3zXZe587NyxFKu+8XpzTxWy2hlE6hsOSZzVJRUxrlr/sQBKaiQ6G3Dlq3RdUqqxfk5Y8W5YQ6JY8a675OYKi95tzCoSsF5ZwaEu9r865qbHA00hwSqNhCwAVPrmI/scn18ktiNzx6c2+gNrm4Ckk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.19; Fri, 25 Oct 2024 14:43:37 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 14:43:37 +0000
Date: Fri, 25 Oct 2024 20:13:26 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Prundeanu, Cristian" <cpru@amazon.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"Doebel, Bjoern" <doebel@amazon.de>,
	"Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
	"Blake, Geoff" <blakgeof@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Csoma, Csaba" <csabac@amazon.com>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
Message-ID: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
References: <C0E39DE3-EEEB-4A08-850F-A4B7EC809E3A@amazon.com>
 <e82c45088ed5aad81f44d4297ff19565e2472ba7.camel@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e82c45088ed5aad81f44d4297ff19565e2472ba7.camel@kernel.crashing.org>
X-ClientProxiedBy: PN2PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::20) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f750eb-b423-43c6-be94-08dcf50368ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1WycdFqdOX7zdjU5OXFkJWZu30toA0/y7hOnYsq6X0gMEfg2f3MFdL4fWBPO?=
 =?us-ascii?Q?i46Nn+6BCWtZSqwk/gzXgiOUUzlPFgvjMAb4gnUENqVpzSMpaNxxMxMlZVWD?=
 =?us-ascii?Q?pRsXJlow0p/rWTobvTcywu1hqjIhQ1CJ0K4GOgdoZPsHC+mdGxJw8x/IqJKy?=
 =?us-ascii?Q?VGoTR3npTuT4TG/kzX7a2p4Ag8N9GkZtKQ93nKHrLiDwf41F652QvPMIX1Ey?=
 =?us-ascii?Q?BRJPDnlgv0FQn6x8L9KtWoJf65gWFCauuMyJ4r7Lo0oMYGS4Ph7r4HWUVstI?=
 =?us-ascii?Q?Fi6DngE7Vxu1QZluvXal8qwtCYWye8xpXyfnkcsw9rErElDSZHfqrS+TVh2I?=
 =?us-ascii?Q?464S0hVGgQGi1WJD1s8nuJP2x2tUGXF1sNdHZIGfksuRvgF+FH6UI711RSQR?=
 =?us-ascii?Q?xQjSHuljLuL85mRIYrfX67KXwgJEslEceGXeNy+uc7GuzNuY7S13cs6c/ook?=
 =?us-ascii?Q?3EAx7QRweAKmNEtS/X0xzxlS0c8uUT8JqIRNeHOGMLLQ/lpyA/6DEcw4jJ24?=
 =?us-ascii?Q?6wKYm7mY+ZSNXDJfZDxjrFwuIdES01o9rLDjJwd2PJ4sy90RMHRV7XAIsSOm?=
 =?us-ascii?Q?WvgWhlnXj0B30gY8fv2WFI51nqWiWCDDNhSlhPmUAJuxiixxvlp6H0CJo2J0?=
 =?us-ascii?Q?/nvOlFCQiR8Kr6ZpiaQvdhg5WqRN/NQsZmmW8OLvKVzpW5J0h/OymANcwzXo?=
 =?us-ascii?Q?PsxRC7fUw0nm+G/tmnJwYoblHpbo60AYNi01agkXim8DyO60z3E51c1F4Mxw?=
 =?us-ascii?Q?gaU5bXuLL7o0TFjF+fYABq1oK6CFuMsWbJbhMycSpcqEurtuC+11g1I0/Po3?=
 =?us-ascii?Q?h41LQtJv4Gc2eHlVJxifaI+VY1SCayQpsfOSzgDDWh97oBB4cTdtelRI3Vgx?=
 =?us-ascii?Q?9XiT0Ih/uJAGeehgx7c7NyPtUK/z4q2JnrHizTpFCc0O6Dqjvy2F3vUMbQl7?=
 =?us-ascii?Q?VRyPwQm74feCgoiLZhnOwVmFupl657OWjGprtRRyv8KZdj5CaeE5BhJjWF90?=
 =?us-ascii?Q?l8mUZT6iEmvpVWrejofPOv7EVoEbwjMGr5BdJ3dKYgHmqfXacXct91YLlts+?=
 =?us-ascii?Q?75/k2cDecXw5fBY6z5WgBs9YuRlm8y8dhXAmrkLbpIarJrBmZ2eZHVI1EinL?=
 =?us-ascii?Q?ILvuxWsmVYypcR5zhhTXc09SxbebYH5eAZwLFA5Mor/d8kegYrR4+S5rl7+X?=
 =?us-ascii?Q?WpNPySpoHYRfSGZNYQMmyQ4zZqLYYs8Ya/vHxk2olvXJqsbJ6Wz9FJoVosxR?=
 =?us-ascii?Q?keR+Pb2NLwSmN9tjd2RCMQWE0ceGYVYa4GnXfymbGzELxm/eQMjrRDpOT5wR?=
 =?us-ascii?Q?bjJNGwODKHsid7du1aIkK3Jl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CdiE9vUEY/sgoHFzociXj8pHJSbqY/pv+IAN1eLd9Sco/06AIEpQJSSFA5x?=
 =?us-ascii?Q?bTLXQFJENt+uruse2OPRydR5gZSzlgONfThtefQQiLcOCGnI0gg8OyEIe/ar?=
 =?us-ascii?Q?UW+Lm+oPp/pensHb+M3/7wdzHzF8aSJ2lppgbR9iHlZJRX1uViqF48vQjsUp?=
 =?us-ascii?Q?lnwII/7TX3p04HYLgG2a8DShI4ESoYoUBQxDDb7SQ77Zv9GSpr0nv10XhJFy?=
 =?us-ascii?Q?hZk4N3HR3Y0JdXcNAoOWC4KG1ZKAwI5eXYZoTFsbPjKqeTYrknjpSkUajrOP?=
 =?us-ascii?Q?52qU2BlY6b88V0TZX3q9NC+P+NrEs+oD5nODVu1MmnG1GW26qN7KFWG3N/39?=
 =?us-ascii?Q?sX5RfunV2mphwc1fG/qs88XifpIj3udtMuhKz0ncB0rJ/JdJ9Vaflo+et3x7?=
 =?us-ascii?Q?KL2K36gtzGWnTmy0kIT7JedFFt1HxpnnLB8sBPH3JepZgftIT+3wy7k71JUB?=
 =?us-ascii?Q?RcjyFxTePFVwQWMZTP05EkVy1t2BHfGOgwBVOEr9K7o2m/IAoLoU0mf6Hgix?=
 =?us-ascii?Q?SsIB/B/iFZ6GPAVhlyIwHi1H9DY6o6X86+/tY+jy89L0Hfr6/oAPnJ0GwQ0g?=
 =?us-ascii?Q?DG/SYeOT1T2oIWVExG8HXB4jlTo54SS/NSj8C80Vt+ZRkYQq9QQMbVSQsCnt?=
 =?us-ascii?Q?JsNk/AT0P5nBPBkxcSDa85upkHfB9m4H5lqPAT5hTaFzKHrdC9gk1IwrLd+7?=
 =?us-ascii?Q?+g5f1Sprsuv+7ci6VNWenXzuiqmWD9WmiPkUKBCzXalH8Ao1sWHjBEpRABsC?=
 =?us-ascii?Q?72uVgBl+GfvnAmW+9Ly9a+iTgKhaFzAIc/cxgltBv3XPyQrn35SkRiYVLpRN?=
 =?us-ascii?Q?DywYO8sWFVRXorvQk7sEBvnNN7o+ay3zkYEj9zq6oXQ/EEUz8GrNotiB2i5u?=
 =?us-ascii?Q?RIk+7WYOOPUl19MbFykKbBvcrM2TeDiXxhn56SxuADZ6WvkXqbJ/zzcmaMTS?=
 =?us-ascii?Q?RqtVjg/UbtCvgILzmxaIqYYrXqOs+3YEc/f8kxW6Qlw81vnP3ZwBo202hhDj?=
 =?us-ascii?Q?JwlRm3g0twC8TzbuKMscF8Xt0giWd+aIqvuNGIMzZaiGLBh4gPiROvPQNxnP?=
 =?us-ascii?Q?5pCjJI0lBmSM0nyvFpiDAEjdVLKE4MgJXQcYyvZdPUGtw8nCdNI/hj5Zgbue?=
 =?us-ascii?Q?dz7xJV03QCrdOFBHNzfp3xvXXGRs2qshxdUEIMlIunD4kL6k01PcUeAsDn/+?=
 =?us-ascii?Q?+p+W2DEtWSRVeUn5YLQKy6x8k15Fg54B1O1BIuoj1eryMvs0tTXT3TzMa6W8?=
 =?us-ascii?Q?DRxg2tuJ90oqGTk5uXv4eDtuGMIoKiWuOus4zgaNyzQWrHPRX0IRqN1bV3/j?=
 =?us-ascii?Q?RzqsIe1sDkSUA3+PY2P49y3sdNp38nnLE3AcQ77mdnPOz2qfGxoUJrnhc2tp?=
 =?us-ascii?Q?UTYQAhH4qmKnqlFc0aN7mVvi3XXWDuUfhJ/SMWCTIjU+phU20kQU/xImld+i?=
 =?us-ascii?Q?8eYpCVvLmQiRFTwYGebDUt0DfPd/jv3nEz8lgMLv1ggC2rFc3FcFXZ0n8ugU?=
 =?us-ascii?Q?HeAOQA1+6C845wA2mOMAPTy4brtxY3NblJQ5sQOYEgG3j1+DMY0+2A4YWqlm?=
 =?us-ascii?Q?repONKxnxLl3CS76V6MmhiT9+/u5LYxG6NiZ0wZv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f750eb-b423-43c6-be94-08dcf50368ba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:43:37.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHCBpjxzoamCgRd6ih7onfpSVjai4hzOa/Nc9+p/9C85nibaap9DIGDT5U/yYRUizfCGiu/GldFv16v67/h3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

Hello Cristian, Ben,

On Thu, Oct 24, 2024 at 07:12:49PM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2024-10-19 at 02:30 +0000, Prundeanu, Cristian wrote:
> > 
> > The hammerdb test is a bit more complex than sysbench. It uses two
> > independent physical machines to perform a TPC-C derived test [1], aiming
> > to simulate a real-world database workload. The machines are allocated as
> > an AWS EC2 instance pair on the same cluster placement group [2], to avoid
> > measuring network bottlenecks instead of server performance. The SUT
> > instance runs mysql configured to use 2 worker threads per vCPU (32
> > total); the load generator instance runs hammerdb configured with 64
> > virtual users and 24 warehouses [3]. Each test consists of multiple
> > 20-minute rounds, run consecutively on multiple independent instance
> > pairs.
> 
> Would it be possible to produce something that Prateek and Gautham
> (Hi Gautham btw !) can easily consume to reproduce ?
> 
> Maybe a container image or a pair of container images hammering each
> other ? (the simpler the better).

Yes, that would be useful. Please share your recipe. We will try and
reproduce it at our end. In our testing from a few months ago (some of
which was presented at OSPM 2024), most of the database related
regressions that we observed with EEVDF went away after running these
the server threads under SCHED_BATCH.

> 
> Cheers,
> Ben.

--
Thanks and Regards
gautham.


Return-Path: <linux-tip-commits+bounces-2752-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEF19BB0DD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Nov 2024 11:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EF61C214AE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Nov 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E31AF0B8;
	Mon,  4 Nov 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a08OoHr3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF818C020;
	Mon,  4 Nov 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715606; cv=fail; b=LcneNANqqXQmZqeyG91KiK2u/WDK/roy+jVMpyi1rHbWGoLj8SYPlrX5dhHGdhSOUHeRJkmK12t0SrnvkA+PyIMiDvrneCRf78C9ooCbns41dUn4Ljy8tfL5RwW2Hh4jIRxYv/Ugcf4fWilkymJmCzXzC91UaLFV4SukKPV4SCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715606; c=relaxed/simple;
	bh=f7lNV3xvmnqgOy8yNjWEKbScVqNdxKlhsRnUmJtw9Vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lew7RyyUftRaWFxF06m2MqdXv8IpuquMjU+/GtgEt8fFj/XNhpWDUzIV0d0otTw69sEKAaCopo8QS1uqN95F/7UOzEa/5NbE82b8GfS7LZ2DEKwsqy+XNKvEmDpxSm+tQUoD9NsJSeMmIhR5XGM2v6feVukOveyV7EWosyuuyoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a08OoHr3; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFjYXXHhd5+nwXX5pFhSumMfgI0VDsD+tB1DaVM0J0xn3/fUMASWx7somzUuZppby/WECBj01vIUI2Qoi2EGI+AuMvvhpaB4C/y1HyWFMdvp2xG1sbQhO21xJgzHzTx5nEfELCxB86pSNYbA1BHDBsRlTRhWJn7x4GNumUvEcU/CkCi/2GCmRJpNsUxzAM35lHmI5YgCTRIMxk2EHC1mRGtBA4OEjYvSgQ0+K3Kq59qTvutH/UC1glSFqtfngsi6cJcGq3w5OawpKFBGR7Nw6MvHgFvL56cgl2vHOuHuAq+Fbe2bzWETkKpZMAuMzpsAf0V0/QA8O8aHBdxk09AL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxurNx6d5AHto7I4f9BSlwdf9oV9NR/+WNt3u4hy+rU=;
 b=awnHL9iQtPOwooKgjplnpQG+Kels8zwiaJ5i7bcrHasNps4+4WnDEFKoEnjNMkO8kR6l+c0BQsja/viDp8m9iCXOztG5WUmdcYXnVx4wfL24shWMoZ6hQhPHItqFAaKze9ALjeKqCDFJ+XcFyxxMAgCK7VLuQ73u3WqRW3UPpf3qcFvz2q/LOb51PAVKr4r8X5gUwUtLNkwfrlND7WqQksdNciTVotX6ee9rONOJ39ceP70FBzYCZlC1Zmuj6y3BhORrYN0vq5kl7oJKRSnAVix5Y4kQLEJmyIecLG1KgKbmcsVB4dLHsCa03/Rf+OIDfOpbY7u7jYM/vV1J93OnxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxurNx6d5AHto7I4f9BSlwdf9oV9NR/+WNt3u4hy+rU=;
 b=a08OoHr3s67mZfc8LUZ4/4codx5onUD95q4QCEwTVrkz0K10uXr0/l8NbEzrKbFPMEYKrDSju7rOAoCImpELZW4NZOBUy6g6Cnd3OpLK97NpgAsmxgJwdfsQyUD35Spv5dtPUEp3TghfEMK5sYZVKem+p61oU88qk7W2HzcJLvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 10:20:01 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::2d0c:4206:cb3c:96b7%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 10:20:01 +0000
Date: Mon, 4 Nov 2024 15:49:49 +0530
From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To: Cristian Prundeanu <cpru@amazon.com>
Cc: linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Bjoern Doebel <doebel@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	Geoff Blake <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
	Csaba Csoma <csabac@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
Message-ID: <ZyifxfSV8k5vC0iG@BLRRASHENOY1.amd.com>
References: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
 <20241029045749.37257-1-cpru@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029045749.37257-1-cpru@amazon.com>
X-ClientProxiedBy: PN2PR01CA0178.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::33) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: be058bef-bb48-4164-8a43-08dcfcba3da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JRloBRTIEdUTwHilknkeCbX684lpKBY8ZAKkbvHaPLC8TlahRjdOmd/T1iQr?=
 =?us-ascii?Q?cdKutRBXKWbix+ctxXUiaqSnFHWlnKiZKOXvIB4Gl5kjn+xIMhXtrFW8yksc?=
 =?us-ascii?Q?+m61+dwr8JK1MWSnCI4l7dooaQiU7Qwoqt1CDN1VPpi3dEAVe3SS4KLeThjC?=
 =?us-ascii?Q?HuVhHR9OkFXxznDOrYXFBkkOA8yZKb8Ad5gy/woL7zoIPZxJpnnDkGf2jMXr?=
 =?us-ascii?Q?7tdf/iV6yc8rcWLSNsgBp6tFz28B+jdvCYaY9J12k3VA4+nZL5oN7y4JeJYu?=
 =?us-ascii?Q?J9BhDevgw93Qqp0y578mnH3dQAgovF/MzPY/qiLExMiiS+CYpg6x3sM855WY?=
 =?us-ascii?Q?Zw404UPyQft00U1RvKAt0yl9mjYtHKZgivAY/xHg/GI1cZxOiQkcjdVcw0L+?=
 =?us-ascii?Q?uFRXsWDo/cikvoIF5iJAvv2Bv6oRZ06pHxhUV6hF3Wx3f+YbJk690jlIuf2h?=
 =?us-ascii?Q?nD6y/w0q8+H0G1+s/BXFhWBEVrR8FDaYBnbHwcBVOSVQAjHF4SyBPHeflvCJ?=
 =?us-ascii?Q?vO9NQrOoe7gnvxKP8UCdc3RorL/J+3M8fYGAQ9Pgoj1Lz4B/HrSRNuBr56AB?=
 =?us-ascii?Q?FhTFnpZZXf1F7pIJoKvOjLRcL8RMKaeuyasmIfdwz+MUt5tOCdGUo2SF3k+p?=
 =?us-ascii?Q?DUaobW3XNsby7KL+7tOTuuidvXMVNiBRFktBV70x1HxUDFLDwepH4O3WnIO5?=
 =?us-ascii?Q?/YNKas2oV/lZfKFdc0t/DGhPb6nwT5/0SHLXACzUq+YzPxNMbM7Ot3Tn5djK?=
 =?us-ascii?Q?cAOfKsJ1U1S5InC12kIqbx8gkG0eWAM10yuqOpcZZ3tgP03hqc9LQKyZZ/RE?=
 =?us-ascii?Q?Jii8y3myRjIaFPPWtU7gUNIqaJhHsRcP5UW86w2LZNCim40wuwSI4e5SiLe9?=
 =?us-ascii?Q?7UfqNhfkK5g7LIKwGQgUcsLUkMmcXxzZWTLQfVgsWqXanGP+txZPOVJwlTxh?=
 =?us-ascii?Q?zH4r6I6iPNMK2wtJCBshtIeoZmsSJ8wHZ4NWlZMNnrOduTtgv7HLDxzegIqD?=
 =?us-ascii?Q?zxiYIeCo/NMzi3Nzg50hmpg3YMGB2vobgJ9MeTcNhq1TOWr4QxdU1OwspFB0?=
 =?us-ascii?Q?SjklDWzfw3RGfOpb3Ylqhzj2I+zGBgxTcfesqn3xfBpLWApLdEL4cudrwKx0?=
 =?us-ascii?Q?6VDuucgu5gCw38QAAPzV9s4u4B6S40yJqH00AQ8cEYI92LmDBwkmNm9/GPCl?=
 =?us-ascii?Q?LHUI1HoKB4IrTxMtrnuorynHcimgYJ0QU2NPsFd9jdvQxr5hQ6gn/Kf6wAp0?=
 =?us-ascii?Q?0pPAneAIcCc+MdNrK+ggbczmCEIvH1xO7oEj4+PY2GsrfkMIt1jodxC91Ezv?=
 =?us-ascii?Q?3MuEKYH02dZGZbhzWweuT+gb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m0PwYhKeaL8tOOkvnLvXiiyU6jDbZqOOpbz1n1PG70K1S4zelWjOXa8tkNiF?=
 =?us-ascii?Q?MPETnY195rGHf1On2YyMnxzOC07mvYX3KVCBaMBAaQ+pwUHSqCK0Wxi35xB7?=
 =?us-ascii?Q?hykqAXPxz8qCmOk+41enamLGCDHH9QJMA/wGKQ/O/qcJCa/ogJ9LivI7sOfK?=
 =?us-ascii?Q?xpCXOZ8Q7n3xZNartRxWAhFMN4BEXeMvDvuudT8Gh21e+DmCQ2uAlAXqw0SN?=
 =?us-ascii?Q?afHbcy//O/0HEjKF+nYNGgDHUqWR5oT1m50qSK8QGv/8Kq3Fd0CS2yphJ9jQ?=
 =?us-ascii?Q?HVIfPK/HGxUUptxLJvRkzQVcu9HCJgnltZzuazIKsI3Tv1S+k7AFR38uig+V?=
 =?us-ascii?Q?sH6gX90Swz+o8zDZ3UV8PbyL9srAxGWNisNtHAREcjg85Yt+Jhv2vw2PagYs?=
 =?us-ascii?Q?5p4bQ0qjMDGZVN8vCfOvxncb2nz1rAqvQVkJYkGJYsagsH+4FDe4SObULtKQ?=
 =?us-ascii?Q?he+JrsoP5p/l99qPIv5US6UzOeqLqVZBF5uksMEj/2ru05BRUjYNCzDkyZPQ?=
 =?us-ascii?Q?+CM4daHaDV6fxPJapn1G28+jsNmzaW9bUCnnzk7JI3JTTSTmFy1Byv1BIHau?=
 =?us-ascii?Q?Xavs1gHrabqLcgLUXNDIzjb+bWguhB+jvI8l0WnIBjFTQN4dfRAsAPLJ5Tpy?=
 =?us-ascii?Q?7cbgWFb1PZTqyIglbUXla/i/A1qRjF7mTDkCt9TLq2FJBwpZBPC8X1zYTajX?=
 =?us-ascii?Q?L78y2aFcvZqvgRnK4QgwbS0rELf0JR/CfhCUZggDBg5+UrUpWvv8LrboNP0t?=
 =?us-ascii?Q?OqSWoWztN25tMQrfvq73GpKj+xwuJ1xdDUSZ7kB8JCVSW6yVwJCXdGt8Bmdf?=
 =?us-ascii?Q?D89Q0m2EmzQEabbqK5cwwyeT1047hX5dukUlWvVZkaTJ+qN9KT/S2ti29gHW?=
 =?us-ascii?Q?ot56rEoenzp+q1I2+LJxM7NHvVZYN4rJ5YXPa9RDxGnj3hn7vf5Hnn0haZyM?=
 =?us-ascii?Q?2it/Uqect0aw79wNyWRIEveFqjYTuRA0RWcQEZKxl2l/qfqN1AxOXcxmAUdF?=
 =?us-ascii?Q?Aqg7AmUsALQBuHEOKXq0MI/iMTyhDbB6EiwmknfGWSJCO2P9pIK4uhq4dtAH?=
 =?us-ascii?Q?TQZZkQNNmIrTr6mfIFse4fICk58NCjlmzTmNximSnih2IvoqrRAxyuGOvNPl?=
 =?us-ascii?Q?rh/Qa457awPXIQgUl7q1PwTCgnMwetEGM0dLwppmQxRu0hRdf+IwfsXS5KQE?=
 =?us-ascii?Q?lsNQqmzN1myytJ8vLomjjki4KahGQ0LDhAT7hS4IsxCfjXWUG3bL1wokynmG?=
 =?us-ascii?Q?HW2PP5iqdw4m2CyT8QI1Fjkgdll6ec7/L6ih2nwsdajqSyDBM27IiznWUS84?=
 =?us-ascii?Q?rjk077cFW9NTBgZDtjfbBzIrjMq3ek8LikR8C/FMjgjH96+fR5wKk5W72dBc?=
 =?us-ascii?Q?a0wtYPV3l+o4TGv/BRPKtvxfI/diDNZdGeiQnoRhzoeHfR3bX8XelIcuUMcL?=
 =?us-ascii?Q?8OOnoYaTmzBvj0R184BXHfAXcvS3qQAAi/vmxYnszYKORYFfLYNTSWYBmWdb?=
 =?us-ascii?Q?J1mHIX3iZ8isULTWpIxKbdKDk18WWEAaT3cxeuEFWY1Mmd5nVkaeuBTHT1/k?=
 =?us-ascii?Q?TNbdYApGvIcrmeeMMX6jbNuze/WgCW2o0haZvirC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be058bef-bb48-4164-8a43-08dcfcba3da3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 10:20:01.1925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeSzSuctgOgYQgTYx6Af7ib3P2tXajbe+ywpitk2d95++tWfHApA05SF0Cn6JOSu+pHFbvVkkZoR1fWq96Yv/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

On Mon, Oct 28, 2024 at 11:57:49PM -0500, Cristian Prundeanu wrote:
> Hi Gautham,
> 
> On 2024-10-25, 09:44, "Gautham R. Shenoy" <gautham.shenoy@amd.com <mailto:gautham.shenoy@amd.com>> wrote:
> 
> > On Thu, Oct 24, 2024 at 07:12:49PM +1100, Benjamin Herrenschmidt wrote:
> > > On Sat, 2024-10-19 at 02:30 +0000, Prundeanu, Cristian wrote:
> > > > 
> > > > The hammerdb test is a bit more complex than sysbench. It uses two
> > > > independent physical machines to perform a TPC-C derived test [1], aiming
> > > > to simulate a real-world database workload. The machines are allocated as
> > > > an AWS EC2 instance pair on the same cluster placement group [2], to avoid
> > > > measuring network bottlenecks instead of server performance. The SUT
> > > > instance runs mysql configured to use 2 worker threads per vCPU (32
> > > > total); the load generator instance runs hammerdb configured with 64
> > > > virtual users and 24 warehouses [3]. Each test consists of multiple
> > > > 20-minute rounds, run consecutively on multiple independent instance
> > > > pairs.
> > > 
> > > Would it be possible to produce something that Prateek and Gautham
> > > (Hi Gautham btw !) can easily consume to reproduce ?
> > > 
> > > Maybe a container image or a pair of container images hammering each
> > > other ? (the simpler the better).
> > 
> > Yes, that would be useful. Please share your recipe. We will try and
> > reproduce it at our end. In our testing from a few months ago (some of
> > which was presented at OSPM 2024), most of the database related
> > regressions that we observed with EEVDF went away after running these
> > the server threads under SCHED_BATCH.
> 
> I am working on a repro package that is self contained and as simple to 
> share as possible.

Sorry for the delay in response. I was away for the Diwali festival.
Thank you for working on the repro package.


> 
> My testing with SCHED_BATCH is meanwhile concluded. It did reduce the 
> regression to less than half - but only with WAKEUP_PREEMPTION enabled. 
> When using NO_WAKEUP_PREEMPTION, there was no performance change compared 
> to SCHED_OTHER.
> 
> (At the risk of stating the obvious, using SCHED_BATCH only to get back to 
> the default CFS performance is still only a workaround, just as disabling 
> PLACE_LAG+RUN_TO_PARITY is; these give us more room to investigate the 
> root cause in EEVDF, but shouldn't be seen as viable alternate solutions.)
> 
> Do you have more detail on the database regressions you saw a few months 
> ago? What was the magnitude, and which workloads did it manifest on?


There were three variants of sysbench + MySQL which showed regression
with EEVDF.

1. 1 Table, 10M Rows, read-only queries.
2. 3 Tables, 10M Rows each, read-only queries.
3. 1 Segmented Table, 10M Rows, read-only queries.

These saw regressions in the range of 9-12%.

The other database workload which showed regression was MongoDB + YCSB
workload c. There the magnitude of the regression was around 17%.

As mentioned by Dietmar, we observed these regressions to go away with
the original EEVDF complete patches which had a feature called
RESPECT_SLICE which allowed a running task to run till its slice gets
over without being preempted by a newly woken up task.

However, Peter suggested exploring SCHED_BATCH which fixed the
regression even without EEVDF complete patchset.

> 
> -Cristian

--
Thanks and Regards
gautham.


Return-Path: <linux-tip-commits+bounces-2879-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38D9D8496
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B605B1639F8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Nov 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F93193072;
	Mon, 25 Nov 2024 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mjQUA8su"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94833185949;
	Mon, 25 Nov 2024 11:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534555; cv=none; b=OH1mafqePR8092av+lbzWGHBV8FnBMR0I/w/Td4UGu6XD1raYNXqlD8eoTozYZ36+6Z8TTGfNqrhI32s6HH4NmS5kDjpVf7VUMKWm4zAlX1xh2BCvWqnPgJOR2cVlnGvLlQkUmw7s52Fstrv62wrMP/9q+xviYupjYSs3Bedmnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534555; c=relaxed/simple;
	bh=g8q8sCd93QsVu18YmyqSF3AQU4Vitxthmm9JvxVX9h8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYF4nwTPMioTSbQqZWzYzQXXl+h8i0WvLlwW8EZNC9oGGVxrEw6WB5vNiQb1Tt7JHeK43kW9BUGbON2r3XL0wvR+nIg+JOqhZHB5OG0OvZC5gcqrFZIBYRMgy0VXatMPOMXrXZOBAEMX2sZ0OLyj5X+900+xrRj8vC1HvuaGVss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mjQUA8su; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732534554; x=1764070554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qI5cqPydCy6loaD3+vJjer5igPbaebhQ8NFF6WG1rWg=;
  b=mjQUA8suhOoW+Boj17ABhzBzdi2p8yXCp09xXrqqismcEFYsdmaBp2Qq
   dvpGn4UJwX0eCRrI2+w9RZSjdj8e0Lgo+3tU0fHUkOtP4TLbCLgJsrCuE
   osjEUag1j2MeAKyhprJ2CPSMF9mvVIPhi72ol7127ElDvfJzPW1TeV4pF
   k=;
X-IronPort-AV: E=Sophos;i="6.12,182,1728950400"; 
   d="scan'208";a="445805720"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 11:35:51 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:10311]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id f8329d89-d797-48b5-9e29-b69abe8c08e8; Mon, 25 Nov 2024 11:35:50 +0000 (UTC)
X-Farcaster-Flow-ID: f8329d89-d797-48b5-9e29-b69abe8c08e8
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 11:35:49 +0000
Received: from 88665a51a6b2.amazon.com (10.106.179.51) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 25 Nov 2024 11:35:47 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: <cpru@amazon.com>
CC: <kprateek.nayak@amd.com>, <abuehaze@amazon.com>, <alisaidi@amazon.com>,
	<benh@kernel.crashing.org>, <blakgeof@amazon.com>, <csabac@amazon.com>,
	<doebel@amazon.com>, <gautham.shenoy@amd.com>, <joseph.salisbury@oracle.com>,
	<dietmar.eggemann@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <x86@kernel.org>
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY and move them to sysctl
Date: Mon, 25 Nov 2024 05:35:35 -0600
Message-ID: <20241125113535.88583-1-cpru@amazon.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017052000.99200-1-cpru@amazon.com>
References: <20241017052000.99200-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

Here are more results with recent 6.12 code, and also using SCHED_BATCH.
The control tests were run anew on Ubuntu 22.04 with the current pre-built
kernels 6.5 (baseline) and 6.8 (regression out of the box).

When updating mysql from 8.0.30 to 8.4.2, the regression grew even larger.
Disabling PLACE_LAG and RUN _TO_PARITY improved the results more than
using SCHED_BATCH.

Kernel   | default  | NO_PLACE_LAG and | SCHED_BATCH | mysql
         | config   | NO_RUN_TO_PARITY |             | version
---------+----------+------------------+-------------+---------
6.8      | -15.3%   |                  |             | 8.0.30
6.12-rc7 | -11.4%   | -9.2%            | -11.6%      | 8.0.30
         |          |                  |             |
6.8      | -18.1%   |                  |             | 8.4.2
6.12-rc7 | -14.0%   | -10.2%           | -12.7%      | 8.4.2
---------+----------+------------------+-------------+---------

Confidence intervals for all tests are smaller than +/- 0.5%.

I expect to have the repro package ready by the end of the week. Thank you
for your collective patience and efforts to confirm these results.


On 2024-11-01, Peter Zijlstra wrote:

>> (At the risk of stating the obvious, using SCHED_BATCH only to get back to 
>> the default CFS performance is still only a workaround,
>
> It is not really -- it is impossible to schedule all the various
> workloads without them telling us what they really like. The quest is to
> find interfaces that make sense and are implementable. But fundamentally
> tasks will have to start telling us what they need. We've long since ran
> out of crystal balls.

Completely agree that the best performance is obtained when the tasks are
individually tuned to the scheduler and explicitly set running parameters.
This isn't different from before.

But shouldn't our gold standard for default performance be CFS? There is a
significant regression out of the box when using EEVDF; how is seeking
additional tuning just to recover the lost performance not a workaround?

(Not to mention that this additional tuning means shifting the burden on
many users who may not be familiar enough with scheduler functionality.
We're essentially asking everyone to spend considerable effort to maintain
status quo from kernel 6.5.)


On 2024-11-14, Joseph Salisbury wrote:

> This is a confirmation that we are also seeing a 9% performance
> regression with the TPCC benchmark after v6.6-rc1.  We narrowed down the
> regression was caused due to commit:
> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
> 
> This regression was reported via this thread:
> https://lore.kernel.org/lkml/1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com/
> 
> Phil Auld suggested to try turning off the PLACE_LAG sched feature. We
> tested with NO_PLACE_LAG and can confirm it brought back 5% of the
> performance loss.  We do not yet know what effect NO_PLACE_LAG will have
> on other benchmarks, but it indeed helps TPCC.

Thank you for confirming the regression. I've been monitoring performance
on the v6.12-rcX tags since this thread started, and the results have been
largely constant.

I've also tested other benchmarks to verify whether (1) the regression
exists and (2) the patch proposed in this thread negatively affects them.
On postgresql and wordpress/nginx there is a regression which is improved
when applying the patch; on mongo and mariadb no regression manifested, and
the patch did not make their performance worse.


On 2024-11-19, Dietmar Eggemann wrote:

> #cat /etc/systemd/system/mysql.service
>
> [Service]
> CPUSchedulingPolicy=batch
> ExecStart=/usr/local/mysql/bin/mysqld_safe

This is the approach I used as well to get the results above.

> My hunch is that this is due to the 'connection' threads (1 per virtual
> user) running in SCHED_BATCH. I yet have to confirm this by only
> changing the 'connection' tasks to SCHED_BATCH.

Did you have a chance to run with this scenario?


Return-Path: <linux-tip-commits+bounces-2883-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DF09D9A3B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 16:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E0CB218FC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Nov 2024 15:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00031D5CDD;
	Tue, 26 Nov 2024 15:12:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448711B85E4;
	Tue, 26 Nov 2024 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633943; cv=none; b=ujxegoQi0HSpGIcf4wLvEzDlMAbZd7Jvw64UcBY4xDnZAKv1yNAjK97cF50ntnC6jWOqKjp523+uUConYdtQw8emBAjaBPNSrCD3J6Qp79dNcgWnqJtDiquEZwLyrZ4U+HbMnwZQpg3ppSJgDntATLAkKcR/yt/pCWrSJCa79Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633943; c=relaxed/simple;
	bh=6yIrsDo7uuH/Wh2L9KpZduZHTrnXxRZBbM8iSiV9dB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6qmfiY4XGt1uoskzRMB1yK8ZZRPoU/WxdowQJMPPaux9H4NOLM/WDYzt2TthMZqG4JauKO36TsTE1Cs7khE7rSl9Oisz9rdIYQ8Kp/T3DOb0eNuYGc2O7l2HGz/qyrbcUzSMEvKiVvoFRJkTmKZN5bU74t3yw/0+WPQ9awd1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0591150C;
	Tue, 26 Nov 2024 07:12:49 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE053F5A1;
	Tue, 26 Nov 2024 07:12:17 -0800 (PST)
Message-ID: <9aa93862-932c-4a17-a3ba-f6335649e555@arm.com>
Date: Tue, 26 Nov 2024 16:12:04 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Cristian Prundeanu <cpru@amazon.com>
Cc: kprateek.nayak@amd.com, abuehaze@amazon.com, alisaidi@amazon.com,
 benh@kernel.crashing.org, blakgeof@amazon.com, csabac@amazon.com,
 doebel@amazon.com, gautham.shenoy@amd.com, joseph.salisbury@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 x86@kernel.org
References: <20241017052000.99200-1-cpru@amazon.com>
 <20241125113535.88583-1-cpru@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241125113535.88583-1-cpru@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/11/2024 12:35, Cristian Prundeanu wrote:
> Here are more results with recent 6.12 code, and also using SCHED_BATCH.
> The control tests were run anew on Ubuntu 22.04 with the current pre-built
> kernels 6.5 (baseline) and 6.8 (regression out of the box).
> 
> When updating mysql from 8.0.30 to 8.4.2, the regression grew even larger.
> Disabling PLACE_LAG and RUN _TO_PARITY improved the results more than
> using SCHED_BATCH.
> 
> Kernel   | default  | NO_PLACE_LAG and | SCHED_BATCH | mysql
>          | config   | NO_RUN_TO_PARITY |             | version
> ---------+----------+------------------+-------------+---------
> 6.8      | -15.3%   |                  |             | 8.0.30
> 6.12-rc7 | -11.4%   | -9.2%            | -11.6%      | 8.0.30
>          |          |                  |             |
> 6.8      | -18.1%   |                  |             | 8.4.2
> 6.12-rc7 | -14.0%   | -10.2%           | -12.7%      | 8.4.2
> ---------+----------+------------------+-------------+---------
> 
> Confidence intervals for all tests are smaller than +/- 0.5%.
> 
> I expect to have the repro package ready by the end of the week. Thank you
> for your collective patience and efforts to confirm these results.

The results I got look different:

SUT kernel arm64 (mysql-8.4.0)

(1) 6.5.13					    baseline	

(2) 6.12.0-rc4 					    -12.9%
	
(3) 6.12.0-rc4 NO_PLACE_LAG			     +6.4%		

(4) v6.12-rc4 SCHED_BATCH			    +10.8%

5 test runs each: confidence level (95%) <= ±0.56%

(2) is still in sync but (3)/(4) looks way better for me.

Maybe a difference in our test setup can explain the different test results:

I use:

HammerDB Load Generator <-> MySQL SUT
192 VCPUs               <-> 16 VCPUs

Virtual users: 256
Warehouse count: 64
3 min rampup
10 min test run time
performance data: NOPM (New Operations Per Minute)

So I have 256 'connection' tasks running on the 16 SUT VCPUS.

> On 2024-11-01, Peter Zijlstra wrote:
> 
>>> (At the risk of stating the obvious, using SCHED_BATCH only to get back to 
>>> the default CFS performance is still only a workaround,
>>
>> It is not really -- it is impossible to schedule all the various
>> workloads without them telling us what they really like. The quest is to
>> find interfaces that make sense and are implementable. But fundamentally
>> tasks will have to start telling us what they need. We've long since ran
>> out of crystal balls.
> 
> Completely agree that the best performance is obtained when the tasks are
> individually tuned to the scheduler and explicitly set running parameters.
> This isn't different from before.
> 
> But shouldn't our gold standard for default performance be CFS? There is a
> significant regression out of the box when using EEVDF; how is seeking
> additional tuning just to recover the lost performance not a workaround?
> 
> (Not to mention that this additional tuning means shifting the burden on
> many users who may not be familiar enough with scheduler functionality.
> We're essentially asking everyone to spend considerable effort to maintain
> status quo from kernel 6.5.)
> 
> 
> On 2024-11-14, Joseph Salisbury wrote:
> 
>> This is a confirmation that we are also seeing a 9% performance
>> regression with the TPCC benchmark after v6.6-rc1.  We narrowed down the
>> regression was caused due to commit:
>> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
>>
>> This regression was reported via this thread:
>> https://lore.kernel.org/lkml/1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com/
>>
>> Phil Auld suggested to try turning off the PLACE_LAG sched feature. We
>> tested with NO_PLACE_LAG and can confirm it brought back 5% of the
>> performance loss.  We do not yet know what effect NO_PLACE_LAG will have
>> on other benchmarks, but it indeed helps TPCC.
> 
> Thank you for confirming the regression. I've been monitoring performance
> on the v6.12-rcX tags since this thread started, and the results have been
> largely constant.
> 
> I've also tested other benchmarks to verify whether (1) the regression
> exists and (2) the patch proposed in this thread negatively affects them.
> On postgresql and wordpress/nginx there is a regression which is improved
> when applying the patch; on mongo and mariadb no regression manifested, and
> the patch did not make their performance worse.
> 
> 
> On 2024-11-19, Dietmar Eggemann wrote:
> 
>> #cat /etc/systemd/system/mysql.service
>>
>> [Service]
>> CPUSchedulingPolicy=batch
>> ExecStart=/usr/local/mysql/bin/mysqld_safe
> 
> This is the approach I used as well to get the results above.

OK.

>> My hunch is that this is due to the 'connection' threads (1 per virtual
>> user) running in SCHED_BATCH. I yet have to confirm this by only
>> changing the 'connection' tasks to SCHED_BATCH.
> 
> Did you have a chance to run with this scenario?

Yeah, I did. The results where worse than running all mysqld threads in
SCHED_BATCH but still better than the baseline.

(5) v6.12-rc4 'connection' tasks in SCHED_BATCH		+6.8%


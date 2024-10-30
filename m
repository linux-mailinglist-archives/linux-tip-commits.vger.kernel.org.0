Return-Path: <linux-tip-commits+bounces-2646-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D449B5FF2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 11:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFBFB22944
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Oct 2024 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CA1E32C9;
	Wed, 30 Oct 2024 10:21:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E731E32BB;
	Wed, 30 Oct 2024 10:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283674; cv=none; b=dOy3Zv9AgIIdlVhRl4cfL505WUTTJBMoI6tYRPSogr6/fxo8hYOhIbIkwknImzpgUSw7L8Vw1Au5ct+lI4QQpTmIq3WnF7iajAs8x4ELRpLLxVLD2onWkpahbKfYPLI7GXP7kJ5jpIZa1WrbTFGjP4kwy+QPqBbz2mj6Dez3MXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283674; c=relaxed/simple;
	bh=bFyfyPa5ynN5tSJoXKygJHVf9Y0VY47AI3w7qL6i3qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BsYRcn8O3crcX1qQE8V3GRUSqgMfELvPHJtMt1Q8cAOOZsBriwZvbOtN71neac/byRa8yOGJI57gwDrTvbHQl+ncuR5gYBkkmHhe5xWsvXsr8/gLeS+UsvsUDMp60FTdFMpcMwUG8KJnQISpWjsX7YE83v6Thu91ocuEMOhVqAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DD0A113E;
	Wed, 30 Oct 2024 03:21:40 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF2DA3F73B;
	Wed, 30 Oct 2024 03:21:07 -0700 (PDT)
Message-ID: <570e25e1-03c2-4ae1-8e4c-447a453a9d34@arm.com>
Date: Wed, 30 Oct 2024 11:21:06 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Cristian Prundeanu <cpru@amazon.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc: linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjoern Doebel <doebel@amazon.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Geoff Blake <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
 Csaba Csoma <csabac@amazon.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>
References: <ZxuujhhrJcoYOdMJ@BLRRASHENOY1.amd.com>
 <20241029045749.37257-1-cpru@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20241029045749.37257-1-cpru@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Christian,

On 29/10/2024 05:57, Cristian Prundeanu wrote:
> Hi Gautham,
> 
> On 2024-10-25, 09:44, "Gautham R. Shenoy" <gautham.shenoy@amd.com <mailto:gautham.shenoy@amd.com>> wrote:
> 
>> On Thu, Oct 24, 2024 at 07:12:49PM +1100, Benjamin Herrenschmidt wrote:
>>> On Sat, 2024-10-19 at 02:30 +0000, Prundeanu, Cristian wrote:
>>>>
>>>> The hammerdb test is a bit more complex than sysbench. It uses two
>>>> independent physical machines to perform a TPC-C derived test [1], aiming
>>>> to simulate a real-world database workload. The machines are allocated as
>>>> an AWS EC2 instance pair on the same cluster placement group [2], to avoid
>>>> measuring network bottlenecks instead of server performance. The SUT
>>>> instance runs mysql configured to use 2 worker threads per vCPU (32
>>>> total); the load generator instance runs hammerdb configured with 64
>>>> virtual users and 24 warehouses [3]. Each test consists of multiple
>>>> 20-minute rounds, run consecutively on multiple independent instance
>>>> pairs.
>>>
>>> Would it be possible to produce something that Prateek and Gautham
>>> (Hi Gautham btw !) can easily consume to reproduce ?
>>>
>>> Maybe a container image or a pair of container images hammering each
>>> other ? (the simpler the better).
>>
>> Yes, that would be useful. Please share your recipe. We will try and
>> reproduce it at our end. In our testing from a few months ago (some of
>> which was presented at OSPM 2024), most of the database related
>> regressions that we observed with EEVDF went away after running these
>> the server threads under SCHED_BATCH.
> 
> I am working on a repro package that is self contained and as simple to 
> share as possible.
> 
> My testing with SCHED_BATCH is meanwhile concluded. It did reduce the 
> regression to less than half - but only with WAKEUP_PREEMPTION enabled. 
> When using NO_WAKEUP_PREEMPTION, there was no performance change compared 
> to SCHED_OTHER.

Which tasks did you set SCHED_BATCH here? I'm assuming the mysql
'connection' tasks on the SUT (1 task for each virtual user I guess).

I did this and see that the regression goes away. I'm using a similar
test setup (hammerdb - mysql on AWS EC2 instances).

I'm not sure yet how reliable my results are. The big unknown is the
host system when I use AWS EC2 instances for hammerdb (Load Gen) and
mysql (server). In case I gather test results over multiple days, the
host system might have changed?

I also tried the (not-mainlined) RESPECT_SLICE (NO_RUN_TO_PARITY)
features which shows similar results compared to SCHED_BATCH for those
threads.

IIRC, RESPECT_SLICE was also helping Gautham to get the performance back
for his 'sysbench + mysql' workload:

OSPM 24 link to his presentation:

https://youtu.be/jrEN4pJiRWU?t=1115

> (At the risk of stating the obvious, using SCHED_BATCH only to get back to 
> the default CFS performance is still only a workaround, just as disabling 
> PLACE_LAG+RUN_TO_PARITY is; these give us more room to investigate the 
> root cause in EEVDF, but shouldn't be seen as viable alternate solutions.)
> 
> Do you have more detail on the database regressions you saw a few months 
> ago? What was the magnitude, and which workloads did it manifest on?
> 
> -Cristian
> 



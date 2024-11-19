Return-Path: <linux-tip-commits+bounces-2872-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 169FC9D2397
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 11:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A387BB2329E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 10:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2A31C2457;
	Tue, 19 Nov 2024 10:29:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370A156661;
	Tue, 19 Nov 2024 10:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732012159; cv=none; b=sJcr94WTlMM0Q+YOs3jelMSq35eS98kdJqtHIUg+i/vfZPfocmSOv0KGr362iw5tNREhrKbn9Mhwrqn9UNAz9TYNHPSxOB0iQ1P8Mo9xHXcM+rKFXmoqSdEOhuU5EWSPvDc+YSQ1Wy2Do9zkND+Z9T3fB8zgxfdcVCIWHaW8nMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732012159; c=relaxed/simple;
	bh=/l0w9koQR7sx/Hf42m3jnMn82PtWrFEz8J3gEw7cA5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etjwzDqfDmB5zujRmeRy+w5XEevIL7fBD2BJfn1x0G7WGvKRSNIbBQfNO4opKC4dm2J8pbckn5Q1/aKgtubEbArSfWV7cAo7Ke4Ueq4mL9WJ1svf6e9ov3TWS5XajlYcsJw9XQDWePV5mL8xXIpH9absBPhGntjSxNP6U2zV0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3139C1596;
	Tue, 19 Nov 2024 02:29:40 -0800 (PST)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 585263F66E;
	Tue, 19 Nov 2024 02:29:08 -0800 (PST)
Message-ID: <3f24c6a9-27d7-46ad-a479-18a806444740@arm.com>
Date: Tue, 19 Nov 2024 11:29:07 +0100
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] [tip: sched/core] sched: Disable PLACE_LAG and
 RUN_TO_PARITY and move them to sysctl
To: Joseph Salisbury <joseph.salisbury@oracle.com>,
 Cristian Prundeanu <cpru@amazon.com>, linux-tip-commits@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, Bjoern Doebel <doebel@amazon.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
 Geoff Blake <blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>,
 Csaba Csoma <csabac@amazon.com>
References: <20241017052000.99200-1-cpru@amazon.com>
 <ca5c6d15-7205-45e0-96a9-e78ab2a52b45@oracle.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <ca5c6d15-7205-45e0-96a9-e78ab2a52b45@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/11/2024 21:10, Joseph Salisbury wrote:

Hi Joseph,

> On 10/17/24 01:19, Cristian Prundeanu wrote:

[...]

> Hi Cristian,
> 
> This is a confirmation that we are also seeing a 9% performance
> regression with the TPCC benchmark after v6.6-rc1.  We narrowed down the
> regression was caused due to commit:
> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
> 
> This regression was reported via this thread:
> https://lore.kernel.org/lkml/1c447727-92ed-416c-bca1-a7ca0974f0df@oracle.com/
> 
> Phil Auld suggested to try turning off the PLACE_LAG sched feature. We
> tested with NO_PLACE_LAG and can confirm it brought back 5% of the
> performance loss.  We do not yet know what effect NO_PLACE_LAG will have
> on other benchmarks, but it indeed helps TPCC.

Can you try to run mysql in SCHED_BATCH when using EEVDF?

https://lkml.kernel.org/r/20241029045749.37257-1-cpru@amazon.com

The regression went away for me when changing mysql threads to SCHED_BATCH.

You can either start mysql with 'CPUSchedulingPolicy=batch':

#cat /etc/systemd/system/mysql.service

[Service]
CPUSchedulingPolicy=batch
ExecStart=/usr/local/mysql/bin/mysqld_safe

# systemctl daemon-reload
# systemctl restart mysql

or change the policy with chrt for all mysql threads when doing
consecutive test runs starting from the 2. run ('connection' threads
have to exists already)

# chrt -b -a -p 0 $PID_MYSQL

# ps -p $PID_MYSQL -To comm,pid,tid,nice,class

COMMAND             PID     TID  NI CLS
mysqld             4872    4872   0 B
ib_io_ibuf         4872    4878   0 B
...
xpl_accept-3       4872    4921   0 B
connection         4872    5007   0 B
...
connection         4872    5413   0 B

My hunch is that this is due to the 'connection' threads (1 per virtual
user) running in SCHED_BATCH. I yet have to confirm this by only
changing the 'connection' tasks to SCHED_BATCH.


[..]


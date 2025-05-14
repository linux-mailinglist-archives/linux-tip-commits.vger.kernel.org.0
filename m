Return-Path: <linux-tip-commits+bounces-5543-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463FAB77EA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 23:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE483164878
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DD1F0E47;
	Wed, 14 May 2025 21:26:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B943B235C01;
	Wed, 14 May 2025 21:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257999; cv=none; b=OsYupaJf98F8VMorEBsLG8ELCjQmmQxrUuW8Ry2gRlhPpyCCSOg9lHiM+kJ+toc4Zsd9gH6QKBbZQq8S9p3BU8b7KlOO8KPX75Bj2i8v5LkGpqQWJZ3Lpn6GnLv/AjTlZDoC+KCge1NS1CQNNDE47ouwmWA3hbF+kkW5geGxgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257999; c=relaxed/simple;
	bh=6A33sYQdjDk+F4iBMB1qydcIOHVTBcwxBUobGMjX9aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdYxQr4wU/VybEO9GWbdO0li0wFMVtjZ7UKHYyOOSuuWl6Ro7XYOXT5YWeoScwvmXV49o206WeYET5SUWtWpKQ1Ym70V2RysjXc/AaJ8bCRQh3BzePw5jGd01BI9tpUGBseTEtbmqGdLr3ptJrARCr8XmFT/IEdUphGy0jn26DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18BB8150C;
	Wed, 14 May 2025 14:26:23 -0700 (PDT)
Received: from [192.168.178.25] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607613F5A1;
	Wed, 14 May 2025 14:26:22 -0700 (PDT)
Message-ID: <d6692902-837a-4f30-913b-763f01a5a7ea@arm.com>
Date: Wed, 14 May 2025 23:26:18 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: EEVDF regression still exists
To: "Prundeanu, Cristian" <cpru@amazon.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "Saidi, Ali" <alisaidi@amazon.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Blake, Geoff" <blakgeof@amazon.com>, "Csoma, Csaba" <csabac@amazon.com>,
 "Doebel, Bjoern" <doebel@amazon.de>, Gautham Shenoy
 <gautham.shenoy@amd.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Joseph Salisbury <joseph.salisbury@oracle.com>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, Chris Redpath <Chris.Redpath@arm.com>
References: <20250429213817.65651-1-cpru@amazon.com>
 <20250429215604.GE4439@noisy.programming.kicks-ass.net>
 <82DC7187-7CED-4285-85FC-7181688CD873@amazon.com>
 <f241b773-fca8-4be2-8a84-5d3a6903d837@amd.com>
 <CFA24C6D-8BC4-490D-A166-03BDF3C3E16C@amazon.com>
 <20250502084844.GT4198@noisy.programming.kicks-ass.net>
 <935376C2-71B9-4E41-9738-99A4BCC55B48@amazon.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <935376C2-71B9-4E41-9738-99A4BCC55B48@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Chris Redpath <Chris.Redpath@arm.com>

On 02/05/2025 18:52, Prundeanu, Cristian wrote:
> On 2025-05-02, 03:50, "Peter Zijlstra" <peterz@infradead.org <mailto:peterz@infradead.org>> wrote:
> 
>> On Thu, May 01, 2025 at 04:16:07PM +0000, Prundeanu, Cristian wrote:
>>
>>> (Please keep in mind that the target isn't to get SCHED_BATCH to the same
>>> level as 6.5-default; it's to resolve the regression from 6.5-default to
>>> 6.6+ default, and from 6.5-SCHED_BATCH to 6.6+ SCHED_BATCH).
>>
>> No, the target definitely is not to make 6.6+ default match 6.5 default.
>>
>> The target very much is getting you performance similar to the 6.5
>> default that you were happy with with knobs we can live with.
> 
> If we're talking about new knobs in 6.6+, absolutely.
> 
> For this particular case, SCHED_BATCH existed before 6.6. Users who already
> enable SCHED_BATCH now have no recourse. We can't, with a straight face,
> claim that this is a sufficient fix, or that there is no regression.
> 
> I am, of course, interested to discuss any knob tweaks as a stop-gap measure.
> (That is also why I proposed moving NO_PLACE_LAG and NO_RUN_TO_PARITY to sysctl
> a few months back: to give users, including distro maintainers, a reasonable
> way to preconfigure their systems in a standard, persistent way, while this is
> being worked on).
> None of this should be considered a permanent solution though. It's not a fix,
> and was never meant to be anything but a short-term relief while debugging the
> regression is ongoing.

I've been running those tests as well on an environment pretty close to
yours. I use c7g.16xlarge and m7gd.16xlarge ('maxcpus=16 nr_cpus=16') AWS
instances for LoadGen (hammerdb) and SUT (mysqld).

We tried to figure out whether only changing the mysql (SUT) 'connection'
tasks to SCHED_BATCH is sufficient to see a performance uplift. There is
one of those tasks per virtual user.

I ran (1)-(3) (like you) plus (4):


(1) default

(2) NO_PL NO_RTP ... run w/ NO_PLACE_LAG and NO_RUN_TO_PARITY

(3) SCHED_BATCH  ... launch mysqld.service with 'CPUSchedulingPolicy=batch'
                     [/lib/systemd/system/mysql.service]

(4) mysql patch  ... run 'connection' threads as SCHED_BATCH


Kernel   | Runtime      | mysql  | Throughput | P50 latency
aarch64  | parameters   | patch* | (NOPM)     | (larger is worse)
---------+--------------+--------+------------+------------------
6.5      | default      |        |  baseline  |  baseline
         | SCHED_BATCH  |        |  +10.9%    |  -42.9%
         | default      |   x    |   +9.5%    |  -33.0%
---------+--------------+--------+------------+------------------
6.6      | default      |        |   -2.7%    |  -23.7%
         | NO_PL NO_RTP |        |   +4.4%    |   +8.8%
         | SCHED_BATCH  |        |   +4.5%    |    -*
         | default      |   x    |   +4.2%    |  -38.8%
---------+--------------+--------+------------+------------------
6.8      | default      |        |   -3.7%    |    -
         | NO_PL NO_RTP |        |   +2.5%    |  -24.0%
         | SCHED_BATCH  |        |   +6.2%    |  -38.6%
         | default      |   x    |   +2.7%    |  -37.0%
---------+--------------+--------+------------+------------------
6.12     | default      |        |   -6.3%    |    -
         | NO_PL NO_RTP |        |   -4.0%    |  -34.1%
         | SCHED_BATCH  |        |   -2.3%    |  -35.9%
         | default      |   x    |   -2.1%    |  -33.6%
---------+--------------+--------+------------+------------------
6.13     | default      |        |   -7.3%    |   -9.2%
         | NO_PL NO_RTP |        |   -3.7%    |  -35.0%
         | SCHED_BATCH  |        |      0%    |  -38.2%
         | default      |   x    |   -1.7%    |  -34.3%
---------+--------------+--------+------------+------------------
6.14     | default      |        |   -7.3%    |  -19.3%
         | NO_PL NO_RTP |        |   -5.3%    |  -36.6%
         | SCHED_BATCH  |        |   -2.9%    |  -40.1%
         | default      |   x    |   -2.4%    |  -39.0%
---------+--------------+--------+------------+------------------
6.15-rc5 | default      |        |   -9.6%    |  -19.3%
         | NO_PL NO_RTP |        |   -7.7%    |  -34.7%
         | SCHED_BATCH  |        |   -5.1%    |  -38.6%
         | default      |   x    |   -5.6%    |    -
---------+--------------+------------+--------+------------------

'-'* 'repro-regression' didn't provide latency numbers

Looks like (4) is almost as good as (3). And we see this uplift also on
CFS (6.5). The patch below is trivial and easily to apply. 

That said, I also see the policy unrelated regression you're describing
(especially from '6.8 -> 6.12' and then from '6.14 -> 6.15-rc5'.

I will have time the next couple of days to also look into these issues
using our setup.

---

Patch applied to mysql-8.0-8.0.42 source package (Ubuntu 22.04):

-->8--

From: Chris Redpath <chris.redpath@arm.com>
Date: Thu, 13 Mar 2025 16:30:13 +0000
Subject: [PATCH] Make sure we use SCHED_BATCH for thread-per-connection mode

Hack in a small change in the thread init code for the handlers to choose
the correct scheduler policy.

Signed-off-by: "Chris Redpath" <chris.redpath@arm.com>
---
 sql/conn_handler/connection_handler_per_thread.cc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sql/conn_handler/connection_handler_per_thread.cc b/sql/conn_handler/connection_handler_per_thread.cc
index 68641b55723..10086cd3c6f 100644
--- a/sql/conn_handler/connection_handler_per_thread.cc
+++ b/sql/conn_handler/connection_handler_per_thread.cc
@@ -249,6 +249,7 @@ static void *handle_connection(void *arg) {
       Connection_handler_manager::get_instance();
   Channel_info *channel_info = static_cast<Channel_info *>(arg);
   bool pthread_reused [[maybe_unused]] = false;
+  struct sched_param param = {0};
 
   if (my_thread_init()) {
     connection_errors_internal++;
@@ -260,6 +261,15 @@ static void *handle_connection(void *arg) {
     return nullptr;
   }
 
+  // Set the scheduling policy to SCHED_BATCH
+  if (sched_setscheduler(0, SCHED_BATCH, &param) == -1) {
+    perror("sched_setscheduler");
+    // Handle the error as needed
+    delete channel_info;
+    my_thread_exit(nullptr);
+    return nullptr;
+  }
+
   for (;;) {
     THD *thd = init_new_thd(channel_info);
     if (thd == nullptr) {
-- 
2.34.1



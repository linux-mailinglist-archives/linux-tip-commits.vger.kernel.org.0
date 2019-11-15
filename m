Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE5FE4B9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Nov 2019 19:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfKOSPk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Nov 2019 13:15:40 -0500
Received: from foss.arm.com ([217.140.110.172]:34854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbfKOSPj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Nov 2019 13:15:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4426C30E;
        Fri, 15 Nov 2019 10:15:39 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F38723F534;
        Fri, 15 Nov 2019 10:15:36 -0800 (PST)
Subject: Re: [tip: sched/urgent] sched/topology, cpuset: Account for
 housekeeping CPUs to avoid empty cpumasks
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc:     mkoutny@suse.com, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar.Eggemann@arm.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, hannes@cmpxchg.org,
        lizefan@huawei.com, morten.rasmussen@arm.com, qperret@google.com,
        tj@kernel.org, vincent.guittot@linaro.org,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
References: <20191104003906.31476-1-valentin.schneider@arm.com>
 <157384158622.12247.6135151696743651397.tip-bot2@tip-bot2>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <26624707-3913-5225-a7f9-f3cf9597d6f2@arm.com>
Date:   Fri, 15 Nov 2019 18:15:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157384158622.12247.6135151696743651397.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On 15/11/2019 18:13, tip-bot2 for Valentin Schneider wrote:
> The following commit has been merged into the sched/urgent branch of tip:
> 
> Commit-ID:     48a723d23b0d957e5b5861b974864e53c6841de8
> Gitweb:        https://git.kernel.org/tip/48a723d23b0d957e5b5861b974864e53c6841de8
> Author:        Valentin Schneider <valentin.schneider@arm.com>
> AuthorDate:    Mon, 04 Nov 2019 00:39:06 
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Fri, 15 Nov 2019 11:02:20 +01:00

Michal just noted this might actually *not* be required. I'm setting up some
tests on qemu right now to convince myself.

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A69316AA9A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2020 17:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBXQBW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 24 Feb 2020 11:01:22 -0500
Received: from foss.arm.com ([217.140.110.172]:39214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbgBXQBW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 24 Feb 2020 11:01:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB16D1FB;
        Mon, 24 Feb 2020 08:01:21 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7FC263F703;
        Mon, 24 Feb 2020 08:01:20 -0800 (PST)
References: <20200224095223.13361-9-mgorman@techsingularity.net> <158255763157.28353.3693734020236686000.tip-bot2@tip-bot2>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/pelt: Add a new runnable average signal
In-reply-to: <158255763157.28353.3693734020236686000.tip-bot2@tip-bot2>
Date:   Mon, 24 Feb 2020 16:01:04 +0000
Message-ID: <jhj36b06klb.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


tip-bot2 for Vincent Guittot writes:

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

With the fork time initialization thing being sorted out, the rest of the
runnable series can claim my

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

but I doubt any of that is worth the hassle since it's in tip already. Just
figured I'd mention it, being in Cc and all :-)

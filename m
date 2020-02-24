Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8716ABDA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2020 17:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXQnS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 24 Feb 2020 11:43:18 -0500
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:32883 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbgBXQnR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 24 Feb 2020 11:43:17 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 11:43:17 EST
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 087D61C38EB
        for <linux-tip-commits@vger.kernel.org>; Mon, 24 Feb 2020 16:34:49 +0000 (GMT)
Received: (qmail 20607 invoked from network); 24 Feb 2020 16:34:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 24 Feb 2020 16:34:48 -0000
Date:   Mon, 24 Feb 2020 16:34:46 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/pelt: Add a new runnable average signal
Message-ID: <20200224163446.GA3466@techsingularity.net>
References: <20200224095223.13361-9-mgorman@techsingularity.net>
 <158255763157.28353.3693734020236686000.tip-bot2@tip-bot2>
 <jhj36b06klb.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <jhj36b06klb.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Feb 24, 2020 at 04:01:04PM +0000, Valentin Schneider wrote:
> 
> tip-bot2 for Vincent Guittot writes:
> 
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
> > Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> With the fork time initialization thing being sorted out, the rest of the
> runnable series can claim my
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> but I doubt any of that is worth the hassle since it's in tip already. Just
> figured I'd mention it, being in Cc and all :-)

Whether the tag gets included or not, it's nice to have definite
confirmation that you're ok with this version!

-- 
Mel Gorman
SUSE Labs

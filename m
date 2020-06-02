Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EAB1EBEDA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jun 2020 17:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBPQK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Jun 2020 11:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgFBPQK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Jun 2020 11:16:10 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E0D20659;
        Tue,  2 Jun 2020 15:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591110970;
        bh=uD50gjeRCke3xI9ptDSmBKRgTyqnBCJf/ONhGVmapuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fUjlbRWjEvt5bHb3gxXmOsU9FYt6taYPjvjrqpaJu3GcALFBb16k4R5sJayjroY3O
         3MwnClqmPSMMKL58bAKM8D+ZTMjUYshowTK2rffheUvRlkWvARmUJX+FnB+Itj2Yic
         akY36VY6dcjssdOwAsvIK2EGqAdjTgjqlZ/CWT7Q=
Date:   Tue, 2 Jun 2020 17:16:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched: Replace rq::wake_list
Message-ID: <20200602151606.GA26002@lenoir>
References: <20200526161908.129371594@infradead.org>
 <159100513859.17951.5366888281495604529.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159100513859.17951.5366888281495604529.tip-bot2@tip-bot2>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Jun 01, 2020 at 09:52:18AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     a148866489fbe243c936fe43e4525d8dbfa0318f
> Gitweb:        https://git.kernel.org/tip/a148866489fbe243c936fe43e4525d8dbfa0318f
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Tue, 26 May 2020 18:11:04 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Thu, 28 May 2020 10:54:16 +02:00
> 
> sched: Replace rq::wake_list
> 
> The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> got smp_call_function_single_async() subtly wrong. Even though it will
> return -EBUSY when trying to re-use a csd, that condition is not
> atomic and still requires external serialization.
> 
> The change in ttwu_queue_remote() got this wrong.
> 
> While on first reading ttwu_queue_remote() has an atomic test-and-set
> that appears to serialize the use, the matching 'release' is not in
> the right place to actually guarantee this serialization.
> 
> The actual race is vs the sched_ttwu_pending() call in the idle loop;
> that can run the wakeup-list without consuming the CSD.
> 
> Instead of trying to chain the lists, merge them.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20200526161908.129371594@infradead.org

Looks good, thanks :)

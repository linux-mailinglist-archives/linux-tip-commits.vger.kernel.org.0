Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D792D427B85
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 17:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbhJIP6p (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhJIP6p (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 11:58:45 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CE6C061570;
        Sat,  9 Oct 2021 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kfS9IFc+ft0tnD2SQEc8vNQr0xV7R9ONfbzwm4T1Iwk=; b=PWCYcdKmk35HrcvAGpSdloB/9b
        SEVDohD5B1iSqbitqfVvxv5tUcWo7uhymHnFSsdZ5Lk0yffvHuyCnQ/J650pI4LuVXJTmgRcBefQN
        cJ4pSi/9rlSVb7cjfmFaYbicdqjLEnjxBy9R0PRccR9o2bCext8XUN0ssrwn0BMdj9XAbF3PiZPa+
        L7a9oJiESw7Py9k1zFHCQxT2av/HdAzvNI/vb1sfhX40DLPqPzLDMJ6VuZntKfaTg+Fft6fwkOq1p
        +DhtN+cd6GhJxsj/GOJ4WQS9ui+P0RNX4mL8+tdt2YjQgUhT4GLL4md8U29Gl0LgANVRtezBeMoW4
        N/fbU2hg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZEiJ-008s2f-2f; Sat, 09 Oct 2021 15:56:43 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 395709811D4; Sat,  9 Oct 2021 17:56:42 +0200 (CEST)
Date:   Sat, 9 Oct 2021 17:56:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [tip: locking/core] futex: Move to kernel/futex/
Message-ID: <20211009155642.GX174703@worktop.programming.kicks-ass.net>
References: <20210923171111.300673-2-andrealmeid@collabora.com>
 <163377403828.25758.17995844716836790939.tip-bot2@tip-bot2>
 <6d99ad7a-8f2a-90af-7dc4-3d763413e045@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d99ad7a-8f2a-90af-7dc4-3d763413e045@collabora.com>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Sat, Oct 09, 2021 at 11:23:36AM -0300, André Almeida wrote:
> Hi Peter,
> 
> Às 07:07 de 09/10/21, tip-bot2 for Peter Zijlstra escreveu:
> > The following commit has been merged into the locking/core branch of tip:
> > 
> > Commit-ID:     77e52ae35463521041906c510fe580d15663bb93
> > Gitweb:        https://git.kernel.org/tip/77e52ae35463521041906c510fe580d15663bb93
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Thu, 23 Sep 2021 14:10:50 -03:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Thu, 07 Oct 2021 13:51:07 +02:00
> > 
> > futex: Move to kernel/futex/
> > 
> > In preparation for splitup..
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: André Almeida <andrealmeid@collabora.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: André Almeida <andrealmeid@collabora.com>
> This Signed-off-by chain seems odd, all patches to 15/22 have this, is
> it right?

Well, I wrote the patch, you reposted it and then I applied it, that
gets me there twice.

Arguably my script got the Suggested-by in the wrong place tho...

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366442EE50
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 12:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhJOKFJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 06:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhJOKFJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 06:05:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B70C061570;
        Fri, 15 Oct 2021 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=+GjdgEYmYa77TGSKp7ss/igEeFbixUKxecFPqt73t1U=; b=m1zPG3XeVys5DU4Gc6V9MxdhP/
        sOIaW2lbS0sQRanhel6BFVVZ9B8gUYJPJIdQHG4nhR2V20NnYgR7MQgYc/Ip5leXGqYfdMoeYNya5
        4zMfdDAxFhwP3RMD2tq1o82jFMhz031i6MatqOc0Kkw1ghDhiK6fdRzyW4fDw0ZlGTQJl/Ch8rQlA
        IwZH4638vdyr09Gri8LjLgWSLECEUNAKYTV4sqcoexlK9eLAChoQP5X3WNLU+WQwa2KToISnwh2gd
        SO/kuNRb9M9mTVVkmRkV3NRcNAteyxj20SbcWFUIhh/RvzHdmKHPG5B9rU/n5b299lY0wWEW7e6iQ
        gYVpHhqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbK1c-008wkN-3g; Fri, 15 Oct 2021 10:01:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56E1E300577;
        Fri, 15 Oct 2021 12:01:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2FAC2202431A0; Fri, 15 Oct 2021 12:01:15 +0200 (CEST)
Date:   Fri, 15 Oct 2021 12:01:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        andrealmeid@collabora.com, x86@kernel.org
Subject: Re: [tip: locking/core] futex: Split out requeue
Message-ID: <YWlRawJbAzE61MbY@hirez.programming.kicks-ass.net>
References: <20210923171111.300673-14-andrealmeid@collabora.com>
 <163377402732.25758.10591795748827044017.tip-bot2@tip-bot2>
 <16b0ac0a69615ecd3ae59b0c32161a0b26b8b3ca.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16b0ac0a69615ecd3ae59b0c32161a0b26b8b3ca.camel@gmx.de>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 13, 2021 at 06:57:15PM +0200, Mike Galbraith wrote:
> On Sat, 2021-10-09 at 10:07 +0000, tip-bot2 for Peter Zijlstra wrote:
> >
> > diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> > index 4969e96..840302a 100644
> > --- a/kernel/futex/futex.h
> > +++ b/kernel/futex/futex.h
> > @@ -3,6 +3,8 @@
> >  #define _FUTEX_H
> >  
> >  #include <linux/futex.h>
> > +#include <linux/sched/wake_q.h>
> 
> +#ifdef CONFIG_PREEMPT_RT
> +#include <linux/rcuwait.h>
> +#endif
> 
> ?
> 
> I needed that for tip-rt to build. It also boots, and futextests are
> happy (whew, futexes hard).

Hmm indeed, I wonder how that happened... anyway, lemme add a patch to
cure that.

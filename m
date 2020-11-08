Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D68C2AAA2B
	for <lists+linux-tip-commits@lfdr.de>; Sun,  8 Nov 2020 10:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgKHJF2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 8 Nov 2020 04:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgKHJF1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 8 Nov 2020 04:05:27 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AF2C0613CF;
        Sun,  8 Nov 2020 01:05:25 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so5180034wme.3;
        Sun, 08 Nov 2020 01:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTNZBKYJ1G1f6Z95iwkriRbl+3lpqOyLnQqlrb4E3MI=;
        b=SVyCi3m7XSEed+6txPdAxhuenlfedG4U98T0WBK87KMW5CbqIsj6t7yYleHdAI00HD
         ma0lYoNceQhicSL6Ie7RfQ6OeG+TgusZhkbUb97AttJB3LD85/lre03tl9oc9ic5YedQ
         GE3gCDNGWFbVBqjhop775wceogjWTuTEgOL6FtCklp3khs6QJBjvpFRJPW2QZgkhTE6g
         Qgsybl8xuvvT0otpyCJOcY6lGv+bIKuuvNkV+XkNwUbVPoZ+CdIUuVrDYOghgs+cz6l1
         u+MIN3DnX+Y4qC4z7Jl6KzLw4G0AP59ALp0DxD+3mdDP27kfymJoy0W+x9kMF5vC2e8/
         AFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mTNZBKYJ1G1f6Z95iwkriRbl+3lpqOyLnQqlrb4E3MI=;
        b=NephOE4CVjPT5yCGWVkBJOzuRVYQ8dTltd+JidhqedRarvNrG0FNP6sA3H8IPFndUw
         y0s84031za+0u4YnieNF+YO+SYDqoofx8nUQ2fMjujlgytoARHMHeBbD9bO/paGHl9qX
         rc927bA0BGC/YYuOXl7//V9by+aUuLeIiOoAC8KuJH6HKCbFuRf/BTg2jNmF4OO7XVGC
         oagewszfp9quJfhN/VP92WuLG3oqvGmYBOgfhKkjXeL5HFXF+EyQWRtHjt0HwARm+/o8
         I2YeueUFTmlQnwH5EdzJ0Z448ck2bbQVjQ43Bu/eBt8XXeOOGhyJYJuAyzq0wQQvpI2a
         cYqw==
X-Gm-Message-State: AOAM5303HUDosITWxEuSrJc8lLECS3KtP/fzMCb1U9ET0689b9HqbOKA
        1X7OEvfn6SsdlU486ME1P7U=
X-Google-Smtp-Source: ABdhPJx5ZmDFpwYhhuqYxO5PCzXdYiKkhbQqTh0Ws7SrjUDZmjN0iowXgd6QygNcB70GpAim3Pj58A==
X-Received: by 2002:a1c:dc43:: with SMTP id t64mr8450029wmg.93.1604826324417;
        Sun, 08 Nov 2020 01:05:24 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o197sm9045599wme.17.2020.11.08.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 01:05:23 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 8 Nov 2020 10:05:21 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, linux-tip-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [tip: perf/kprobes] locking/atomics: Regenerate the
 atomics-check SHA1's
Message-ID: <20201108090521.GA108695@gmail.com>
References: <160476203869.11244.7869849163897430965.tip-bot2@tip-bot2>
 <20201107160444.GB30275@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107160444.GB30275@zn.tnic>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Sat, Nov 07, 2020 at 03:13:58PM -0000, tip-bot2 for Ingo Molnar wrote:
> > The following commit has been merged into the perf/kprobes branch of tip:
> > 
> > Commit-ID:     a70a04b3844f59c29573a8581d5c263225060dd6
> > Gitweb:        https://git.kernel.org/tip/a70a04b3844f59c29573a8581d5c263225060dd6
> > Author:        Ingo Molnar <mingo@kernel.org>
> > AuthorDate:    Sat, 07 Nov 2020 12:54:49 +01:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Sat, 07 Nov 2020 13:20:41 +01:00
> > 
> > locking/atomics: Regenerate the atomics-check SHA1's
> > 
> > The include/asm-generic/atomic-instrumented.h checksum got out
> > of sync, so regenerate it. (No change to actual code.)
> > 
> > Also make scripts/atomic/gen-atomics.sh executable, to make
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > it easier to use.
    ^^^^^^^^^^^^^^^^^

> >  mode change 100644 => 100755 scripts/atomic/gen-atomics.sh
> 		^^^^^^^^^^^^^^^
> 
> That looks like it snuck in but it shouldn't have...

So that mode change to executable was intentional, as mentioned in the 
changelog.

Or did I miss something?

Thanks,

	Ingo

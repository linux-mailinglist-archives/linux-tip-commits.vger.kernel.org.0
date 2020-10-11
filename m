Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1FF28A7F0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388155AbgJKPZf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 11:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388147AbgJKPZf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 11:25:35 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07691C0613CE
        for <linux-tip-commits@vger.kernel.org>; Sun, 11 Oct 2020 08:25:34 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h12so10243845qtu.1
        for <linux-tip-commits@vger.kernel.org>; Sun, 11 Oct 2020 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGEksLvJBorAum0Eg2LkfQURApI/RYBperS6Phu5I0I=;
        b=MqGhnaMFfjF44Q19jKunraF6dqyDzXyHADq9GnBKu2Jn9/FGqElIC3zwlMFK4J1Mdv
         /oN/++G9uBO6ms3mpCE6i2JTLMFuC+VgiGZxUclTZFvvGErS5zeAn2aMcygAYQr/kUaH
         LmFWgMVGRtSv4HsrYF+1hv8KuOGgMfqMnBKmyx6Z7EAZP+q0/6O9F0wG7194wkhPF8rh
         hc7liYa58o1+6A60AHgh4zSERIYtfqr8fyWd/JB0Y2E9Rl5wEQufLPDD8gu5YW15ruMl
         ONWmLHQtkZzQrYnYR+qsQLO+cfyBBN4CpaoUzz2yN60V96y4IBJIx4RRwQNztLMq+eUT
         Mz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGEksLvJBorAum0Eg2LkfQURApI/RYBperS6Phu5I0I=;
        b=OXnMBYNyDfGz8KxRK3tFddUrDQlgBGKLN8ozCYYlSFUCJfn4Ps/BjKAfAHHYDxBb3X
         asifThMXybq2600awCwL5XX8yBqJeDpy1FesSd320BoRH+Dm0HDt1lZ48f6C3t6/OTxW
         qtnThSORUKnRUuWlNk8EYTrYZR8dKBZvQX/VnTXEa0gYfMPeZM5bl4F6ezHquPfFWC+a
         g+UGmrmvkkGzP8CFEc7015YYWkWze6NrQavmQ524QMS2asdauUNw67mB5WuaMkCyVA5l
         +D55M39/uw3S3zL4g/KI6cWeNSFIu1IkJarZQS7HZS2S441pBl+qlLWiG/24RM35OiFE
         JMFg==
X-Gm-Message-State: AOAM533dz/tdpZf9KppYCbxs705WjtUQiEjnuXZw0izs4+QTqxTyrnwS
        SnWFyE55aCUbUe3zVlpK3wt/aew+0q+OKVAtwiLEVQ==
X-Google-Smtp-Source: ABdhPJy+hAh5Q/SslIBt8l2bF/IWajPg9z1EuHB9Omzsu39O4mjN85e/do3gycWS56FTghnGu+6RDKd/cePYkO1PiF4=
X-Received: by 2002:ac8:738c:: with SMTP id t12mr6241994qtp.257.1602429933815;
 Sun, 11 Oct 2020 08:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134904.663914713@linutronix.de> <158991831479.17951.17390452716048622271.tip-bot2@tip-bot2>
In-Reply-To: <158991831479.17951.17390452716048622271.tip-bot2@tip-bot2>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 11 Oct 2020 17:25:22 +0200
Message-ID: <CACT4Y+bTZFkuZd7+bPArowOv-7Die+WZpfOWnEO_Wgs3U59+oA@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Convert Divide Error to IDTENTRY
To:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     linux-tip-commits <linux-tip-commits@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, May 19, 2020 at 9:59 PM tip-bot2 for Thomas Gleixner
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/entry branch of tip:
>
> -DO_ERROR(X86_TRAP_DE,     SIGFPE,  FPE_INTDIV,   IP, "divide error",        divide_error)
>
> +DEFINE_IDTENTRY(exc_divide_error)
> +{
> +       do_error_trap(regs, 0, "divide_error", X86_TRAP_DE, SIGFPE,
> +                     FPE_INTDIV, error_get_trap_addr(regs));
> +}

I suppose this is a copy-paste typo and was supposed to be "divide
error", right?
Otherwise it changes how kernel oopses look like and breaks syzkaller
crash parsing, and probably of every other kernel testing system that
looks for kernel crashes.

syzkaller now says just the following for divide errors, without
attribution to function/file/maintainers:

kernel panic: Fatal exception (3)
FS:  0000000000000000(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c9428 CR3: 0000000009e8d000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 86400 seconds..

I will fix it up in syzkaller. It is now required anyway since this
new crash mode is in git history, so needed for bisection and testing
of older releases.

It is not the first time kernel crash output changes
intentionally/unintentionally breaking kernel testing.
But I wonder if LKDTM can be turned into actual executable tests that
produce pass/fail and fix crash output for different oopses?
Marco, you implemented some "output tests" for KCSAN. Can that be
extended to other crash types? With some KUnit help? However, I am not
sure about hard panics, they may not play well with unit-testing...

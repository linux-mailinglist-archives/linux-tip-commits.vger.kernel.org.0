Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298C51DC20C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 May 2020 00:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgETWaw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 May 2020 18:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbgETWaw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 May 2020 18:30:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179E1C061A0E
        for <linux-tip-commits@vger.kernel.org>; Wed, 20 May 2020 15:30:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id h7so3901255otr.3
        for <linux-tip-commits@vger.kernel.org>; Wed, 20 May 2020 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4meyUv3apA8iPicPJAJdGUiEC8vQmDAeMhqbnd2+eRA=;
        b=sN/5GAbLyv5S/YTIO3jPXHKk/tSB1ZTxqYGNbtJc7wDZ2bZeQo5Q1J0aVDMkn89qOC
         QYoeACQBxyB9swUKayNAX5GG3boQb7wfGXiZTggIkZtQK4tBUrgUtXBQ9iUdMHx5Zw+Y
         6nF8/RGFZKwheRzR3Z+FPeIJEIBPXXbA/Tnhlv8fw38SnqdRUab44lVo1qdNhCQuja7j
         /kVO7KGlAxNZdcZwuVI23DEXW7/3ShQRML4/PiBQ2o6czcKnFBrj80M4JiyQn5+vx9sg
         uS1X94Pq1SX8DV1tFZPidkXnNieyCeKxMlUnHITPfz4ahGkYrVn80hopyvA/OcnITsp2
         2afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4meyUv3apA8iPicPJAJdGUiEC8vQmDAeMhqbnd2+eRA=;
        b=lpBA2njURlPm+DkUifLTDguFyRUN+Cj+QQTt04qKu6MDWB+eNFCPTwiENuUEKsYtiH
         0V5hTzeW7oJPPrTxFbsqUPAqZb+VIZPhQlrL/IMXX3bm9oAweYJaYex6Fyq2Rvp4RqX1
         C14hQZondOSRLfQ0R3CtCVFt3DFW8sNR0TKwz6SughGL3X5d3Y9sT2WqMmN3ciqe6q8l
         ojGuNt/wxVlpglX2kOeYLRWDVUZ2/Kw2jaZebD+o5r12T1kR0qxZg4DfYOYqNop4ETCz
         q5sivwQh8RsmFcrRdE3mh+kA35c0HjSB8Kw/vDBxjzesuWI6D/vFoIfuL25wEiCh6C2k
         uXYw==
X-Gm-Message-State: AOAM532ZXcYDPy0gimiwc273EMY5rrxH4DCwyr83MTGWQLaR7B75bYSj
        UXSiVJdo5ONTisofm/3zcYxdAXp8IiDMSplrBusu2Q==
X-Google-Smtp-Source: ABdhPJy4Jgra/VNng6E/OpyCiywEvyOQ+aFnAf0/rGeNsLRikA2hO5jssErrlOqsxruEzeJyspzmmfi2HrGN5TXfzyA=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr5249187otb.233.1590013850956;
 Wed, 20 May 2020 15:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200511204150.27858-18-will@kernel.org> <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic>
In-Reply-To: <20200520221712.GA21166@zn.tnic>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 00:30:39 +0200
Message-ID: <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN instrumentation
To:     Borislav Petkov <bp@alien8.de>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, 21 May 2020 at 00:17, Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> On Tue, May 12, 2020 at 02:36:53PM -0000, tip-bot2 for Will Deacon wrote:
> > The following commit has been merged into the locking/kcsan branch of tip:
> >
> > Commit-ID:     cdd28ad2d8110099e43527e96d059c5639809680
> > Gitweb:        https://git.kernel.org/tip/cdd28ad2d8110099e43527e96d059c5639809680
> > Author:        Will Deacon <will@kernel.org>
> > AuthorDate:    Mon, 11 May 2020 21:41:49 +01:00
> > Committer:     Thomas Gleixner <tglx@linutronix.de>
> > CommitterDate: Tue, 12 May 2020 11:04:17 +02:00
> >
> > READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> >
> > Rather then open-code the disabling/enabling of KCSAN across the guts of
> > {READ,WRITE}_ONCE(), defer to the data_race() macro instead.
> >
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Cc: Marco Elver <elver@google.com>
> > Link: https://lkml.kernel.org/r/20200511204150.27858-18-will@kernel.org
>
> so this commit causes a kernel build slowdown depending on the .config
> of between 50% and over 100%. I just bisected locking/kcsan and got
>
> NOT_OK: cdd28ad2d811 READ_ONCE: Use data_race() to avoid KCSAN instrumentation
> OK:     88f1be32068d kcsan: Rework data_race() so that it can be used by READ_ONCE()
>
> with a simple:
>
> $ git clean -dqfx && mk defconfig
> $ time make -j<NUM_CORES+1>
>
> I'm not even booting the kernels - simply checking out the above commits
> and building the target kernels. I.e., something in that commit is
> making gcc go nuts in the compilation phases.

This should be fixed when the series that includes this commit is applied:
https://lore.kernel.org/lkml/20200515150338.190344-9-elver@google.com/

Thanks,
-- Marco

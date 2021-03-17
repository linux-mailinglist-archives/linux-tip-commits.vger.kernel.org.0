Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32C33F53F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhCQQQF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbhCQQPj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 12:15:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C9C06174A;
        Wed, 17 Mar 2021 09:15:38 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615994206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jfgoTf0THbu0vsgjl5aXpXNzES3/3RlH+G+4z8IKcU=;
        b=tzGjF4GeTF+HRDpqAjidV6Gdyz2BbUXknhzNZyD02xWzJiRbJV5yNuEEwMEGPbUJ8yHDd8
        6ftna/y+VR0k4+x1+c7VkvWbD81G8YlnALcZfxaEEBopktTZRodi2sv8Zhny0GGWzTzewV
        kbb+ht3+mCAfHqxgR2tjJkzHNnrNHRAPjBKHlgabuGanJLxR+s6D31HAu/jag1BCluGA0L
        NvzieD0ISVGRCl081dUvPkTMuVg37ozkIvehSYph++GkFgi47xMoL6Vxe5GGYp0Rq3DjMX
        ivQ91t9ASEuE5cUG7gMa1+gcPYHerK7EHgWS3J96wIT2BjtvOZQuItkCM3gubA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615994206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jfgoTf0THbu0vsgjl5aXpXNzES3/3RlH+G+4z8IKcU=;
        b=Wc2ae3DWXPesuRvd07ZpHfYlSndrgrW44RQfkz/19vJ4r3fHVPaL6bav0iTM189GWIxVwW
        rzdDNIE5YnjjWwBg==
To:     tip-bot2 for Nicholas Piggin <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [tip: sched/core] sched/wait_bit, mm/filemap: Increase page and bit waitqueue hash size
In-Reply-To: <161598470782.398.7078277215554525953.tip-bot2@tip-bot2>
References: <20210317075427.587806-1-npiggin@gmail.com> <161598470782.398.7078277215554525953.tip-bot2@tip-bot2>
Date:   Wed, 17 Mar 2021 16:16:46 +0100
Message-ID: <87v99pyfmp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Mar 17 2021 at 12:38, tip-bot wrote:
> The following commit has been merged into the sched/core branch of tip:
>
> Commit-ID:     873d7c4c6a920d43ff82e44121e54053d4edba93
> Gitweb:        https://git.kernel.org/tip/873d7c4c6a920d43ff82e44121e54053d4edba93
> Author:        Nicholas Piggin <npiggin@gmail.com>
> AuthorDate:    Wed, 17 Mar 2021 17:54:27 +10:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 17 Mar 2021 09:32:30 +01:00

Groan. This does not even compile and Nicholas already sent a V3 in the
very same thread. Zapped ...

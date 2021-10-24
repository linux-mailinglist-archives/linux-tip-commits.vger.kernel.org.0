Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B99438A0E
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Oct 2021 17:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhJXPmn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 24 Oct 2021 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhJXPmb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 24 Oct 2021 11:42:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C0C061225;
        Sun, 24 Oct 2021 08:40:10 -0700 (PDT)
Date:   Sun, 24 Oct 2021 15:40:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635090009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZpIOWtSoVAiWVDmrH4d/R7TOIrXRAZqOUZ8k2AZpPc=;
        b=mr7GxykeZYDK49u38NjTLkz0uMVn0TtHYJeV4iAvfgYpNC7RcEX9ZgZS/Z2b177oH5U0Ku
        PmxX2mcifsn6JfjgCUzbaI7CRXN7/8fgIxW+2z+FYMNyw5dmz9RWXmFLEEky7vZL5rpuDj
        V08NlYB5CEwnIS7V5Ap6O1kLK7HteUEyrQ1+yatWIHgcfvOaVGkMX85eoSCRqjDs3sL02J
        FAp3cp9+Y5qCuawq4+rvYFNmq735A2wtAusMq9jGMBSTEqkNO/uRPCOXMq1bWlY7hGkT00
        L65m3qNpbiuixhhUH24btY0JgUCrCO6reX3l2LxiyPzOzHyM4hRvgerkFbXgcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635090009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ZpIOWtSoVAiWVDmrH4d/R7TOIrXRAZqOUZ8k2AZpPc=;
        b=4WJ9M0PMu4FtFDg+md8k78h5Ubqra/8bD4uaj/qJLPnHQrZyjOOSjpevX1vsHc27U9FEdr
        IjgRomqJhs6vFTBg==
From:   "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] Merge branch 'timers/drivers/armv8.6_arch_timer'
 into timers/drivers/next
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211017124225.3018098-1-maz@kernel.org>
References: <20211017124225.3018098-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <163509000878.626.12963963452743331271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     32cf6d0ae0d86a31aa21b5d8ce6820486027c254
Gitweb:        https://git.kernel.org/tip/32cf6d0ae0d86a31aa21b5d8ce6820486027c254
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 10:07:28 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 19 Oct 2021 10:07:28 +02:00

Merge branch 'timers/drivers/armv8.6_arch_timer' into timers/drivers/next

The branch is a stable branch shared with ARM maintainers for the
first 13th patches of the series:

It is based on v5.14-rc3.

As stated by the changelog:

" [... ] enabling ARMv8.6 support for timer subsystem, and was prompted by a
discussion with Oliver around the fact that an ARMv8.6 implementation
must have a 1GHz counter, which leads to a number of things to break
in the timer code:

- the counter rollover can come pretty quickly as we only advertise a
  56bit counter,
- the maximum timer delta can be remarkably small, as we use the
  countdown interface which is limited to 32bit...

Thankfully, there is a way out: we can compute the minimal width of
the counter based on the guarantees that the architecture gives us,
and we can use the 64bit comparator interface instead of the countdown
to program the timer.

Finally, we start making use of the ARMv8.6 ECV features by switching
accesses to the counters to a self-synchronising register, removing
the need for an ISB. Hopefully, implementations will *not* just stick
an invisible ISB there...

A side effect of the switch to CVAL is that XGene-1 breaks. I have
added a workaround to keep it alive.

I have added Oliver's original patch[0] to the series and tweaked a
couple of things. Blame me if I broke anything.

The whole things has been tested on Juno (sysreg + MMIO timers),
XGene-1 (broken sysreg timers), FVP (FEAT_ECV, CNT*CTSS_EL0).
"

Link: https://lore.kernel.org/r/20211017124225.3018098-1-maz@kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

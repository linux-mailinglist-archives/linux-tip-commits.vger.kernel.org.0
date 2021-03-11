Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72D9337C8D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Mar 2021 19:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhCKSZN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Mar 2021 13:25:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42002 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhCKSY4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Mar 2021 13:24:56 -0500
Date:   Thu, 11 Mar 2021 18:24:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615487095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WagPQJUOx8909nPdwiVdiaa1kDFPntJN6IDR53f7O6E=;
        b=sCMD8h16c3XIlpBPdk06Zr6gicHOBKcv1o6L7/xJcEE+exPAHmM7Q/IU1fmGPQaJGR6nkX
        C28p8zCkZD7t2dhfafn4ADDwgJtxKTtU/GZWK9wpxAw0LKn+9d7zsnKWMj7K45zbfMveF/
        uufTmWIFsgi1DkaxxIONEBIyaIECbunhCKRRfhbzizizcD9hddxhWnslcM52TtpOfVbGfZ
        886Y7ieRjk0ilWcYmnr5RLnjgcf33uN2ySVxS0Y4Z0CH++hkMXU2RlxVHT1mVdk57D88C1
        agsGZODyMfjdtQY/g7JCDD5bWM4+1sRixmXgNP6M8lPqVsQohnCkAocTwTfUDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615487095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WagPQJUOx8909nPdwiVdiaa1kDFPntJN6IDR53f7O6E=;
        b=XIz8clgSUl9C7YzATznfsHTA1z8J9+gqQCvp4BJ+YfhkgoLvMPUmIAR+TcogVoRjzNXJiZ
        BnrHpUYdsHwDczCQ==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kernel/futex: Explicitly document pi_lock for
 pi_state owner fixup
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210226175029.50335-4-dave@stgolabs.net>
References: <20210226175029.50335-4-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <161548709438.398.306866505204753434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c2e4bfe0eef313eeb1c4c9d921be7a9d91d5d71a
Gitweb:        https://git.kernel.org/tip/c2e4bfe0eef313eeb1c4c9d921be7a9d91d5d71a
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Fri, 26 Feb 2021 09:50:29 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Mar 2021 19:19:17 +01:00

kernel/futex: Explicitly document pi_lock for pi_state owner fixup

This seems to belong in the serialization and lifetime rules section.
pi_state_update_owner() will take the pi_mutex's owner's pi_lock to
do whatever fixup, successful or not.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210226175029.50335-4-dave@stgolabs.net

---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index dcd6132..4750557 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -981,6 +981,7 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
  * p->pi_lock:
  *
  *	p->pi_state_list -> pi_state->list, relation
+ *	pi_mutex->owner -> pi_state->owner, relation
  *
  * pi_state->refcount:
  *

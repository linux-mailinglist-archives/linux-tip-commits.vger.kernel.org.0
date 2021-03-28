Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E034BE7C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Mar 2021 21:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhC1TO4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 28 Mar 2021 15:14:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39186 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhC1TOa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 28 Mar 2021 15:14:30 -0400
Date:   Sun, 28 Mar 2021 19:14:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616958869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7q17n1qLRU72vjuJIbZj6G6C64PgEKCB3CZsHnSDOU=;
        b=TjUwvaZUSd+X7SvSElThvKRA53EADtxAZ8vOzw3xgaYaWB1wghcjEbnGIW8Z5alDib2+6X
        2hc7isQqf+QSzrtnyxjdwH5z4dqI3ulw/rnJWhtap1d2u/ISebY0mZ/9IzKJCuuI8/Ypck
        409jxJlsUePE8j97M7xqesdCU06MhOOE/ejQ9vxeaIgV5MIGflimDYn7FHQNpuFyT1wH/8
        SVDWGPbqvPpLVO9ijMoHLuzIS/1yoVU6c3U+kS9tPXmtc+BLOFy1fzS0DK8bs5RJDcT+0T
        p4BrS+c15C9yLqQ+ltHwWcVqLDuWjM+/WXCJx1V7qeGQz8OyoWHKLTaw9mBKNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616958869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7q17n1qLRU72vjuJIbZj6G6C64PgEKCB3CZsHnSDOU=;
        b=/yc4YnDnIFwWKPmmGFFiwrL+kvEw+ki/bZa/Z2bzshorToYQNj+kLwkQhBA8KqirqQXmm4
        vZONgDmhqTwIeeAw==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] MAINTAINERS: Add myself as futex reviewer
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210122171101.15991-1-dave@stgolabs.net>
References: <20210122171101.15991-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <161695886835.398.13402213412656755069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     bd9a5fc2edb0bdcb0756298daa31ddd6a02f0634
Gitweb:        https://git.kernel.org/tip/bd9a5fc2edb0bdcb0756298daa31ddd6a02f0634
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Fri, 22 Jan 2021 09:11:01 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 28 Mar 2021 21:12:42 +02:00

MAINTAINERS: Add myself as futex reviewer

I'm volunteering to help review some of the pain.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210122171101.15991-1-dave@stgolabs.net

---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121..8c31c77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7363,6 +7363,7 @@ M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Ingo Molnar <mingo@redhat.com>
 R:	Peter Zijlstra <peterz@infradead.org>
 R:	Darren Hart <dvhart@infradead.org>
+R:	Davidlohr Bueso <dave@stgolabs.net>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core

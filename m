Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3719657E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Mar 2020 12:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgC1LGW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 28 Mar 2020 07:06:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55626 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgC1LGV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 28 Mar 2020 07:06:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9IC-0003uQ-3Y; Sat, 28 Mar 2020 12:06:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0A241C03A9;
        Sat, 28 Mar 2020 12:06:19 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:06:19 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sh: no need of access_ok() in
 arch_futex_atomic_op_inuser()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539357935.28353.8912910787081630446.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0bea4f7beb68db927a05ff4c08b3ce9f32d043f9
Gitweb:        https://git.kernel.org/tip/0bea4f7beb68db927a05ff4c08b3ce9f32d043f9
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sun, 16 Feb 2020 10:27:46 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Fri, 27 Mar 2020 23:58:52 -04:00

sh: no need of access_ok() in arch_futex_atomic_op_inuser()

everything it uses is doing access_ok() already

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sh/include/asm/futex.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/include/asm/futex.h b/arch/sh/include/asm/futex.h
index 324fa68..b39cda0 100644
--- a/arch/sh/include/asm/futex.h
+++ b/arch/sh/include/asm/futex.h
@@ -34,9 +34,6 @@ static inline int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval,
 	u32 oldval, newval, prev;
 	int ret;
 
-	if (!access_ok(uaddr, sizeof(u32)))
-		return -EFAULT;
-
 	do {
 		ret = get_user(oldval, uaddr);
 

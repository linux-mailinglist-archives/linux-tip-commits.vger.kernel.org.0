Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDF2C26B6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387805AbgKXNCM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 08:02:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387663AbgKXNCL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 08:02:11 -0500
Date:   Tue, 24 Nov 2020 13:02:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606222929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GHEmvPXyGuw9q1MJT6GBRgcxy9rMO/qli32/gGVjR0=;
        b=tDfHnKOjyThGsKHX+VBdbgrwEmHO0USSDG+AdBMRnpUVjbBReU8z/SwMf+skiz2fKu2tQs
        W3I/Llq7MC9jyqHcwRih29j0Q0XrPcbBTRyeFXSCmrD77v8G4+bsltdzBKmlzX8RSGBQEJ
        9gqHt1J2SRnkfs/WumZFkXXBzs9zqXYt4fCWEkZqQ77sojmVezfg8ts2ujHS2PJVeuUt7P
        exJ8yuR+LGxeWtdYsAhzhzzJz/lPMYZOjf48iU/CRAmohL2iiRQvJNWUhrfUd4xI9QZzm8
        nTK3US4yYVb+Ray7vvdcXBA1IsAGjHutbQRU0+L+QPvBI4s6ezGALTH8NVnrnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606222929;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GHEmvPXyGuw9q1MJT6GBRgcxy9rMO/qli32/gGVjR0=;
        b=mj8j3oZSJ2afV5Qu372Q0003fMTgRyr4RXhz6XQOsgOOeA42hBpbD0uvaGXrDY/ZfibzQW
        vJnCDZOwFPFdLSBA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] selftests/x86: Add missing .note.GNU-stack sections
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <6f043c03e9e0e4557e1e975a63b07a4d18965a68.1604346596.git.luto@kernel.org>
References: <6f043c03e9e0e4557e1e975a63b07a4d18965a68.1604346596.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <160622292818.11115.9970136323410049787.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     aeaaf005da1de075929e56562dced4a58238efc4
Gitweb:        https://git.kernel.org/tip/aeaaf005da1de075929e56562dced4a58238efc4
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Mon, 02 Nov 2020 11:51:11 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 24 Nov 2020 13:55:39 +01:00

selftests/x86: Add missing .note.GNU-stack sections

Several of the x86 selftests end up with executable stacks because
the asm was missing the annotation that says that they are modern
and don't need executable stacks.  Add the annotations.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/6f043c03e9e0e4557e1e975a63b07a4d18965a68.1604346596.git.luto@kernel.org
---
 tools/testing/selftests/x86/raw_syscall_helper_32.S | 2 ++
 tools/testing/selftests/x86/thunks.S                | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/x86/raw_syscall_helper_32.S b/tools/testing/selftests/x86/raw_syscall_helper_32.S
index 94410fa..a10d36a 100644
--- a/tools/testing/selftests/x86/raw_syscall_helper_32.S
+++ b/tools/testing/selftests/x86/raw_syscall_helper_32.S
@@ -45,3 +45,5 @@ int80_and_ret:
 
 	.type int80_and_ret, @function
 	.size int80_and_ret, .-int80_and_ret
+
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/x86/thunks.S b/tools/testing/selftests/x86/thunks.S
index 1bb5d62..a2d47d8 100644
--- a/tools/testing/selftests/x86/thunks.S
+++ b/tools/testing/selftests/x86/thunks.S
@@ -57,3 +57,5 @@ call32_from_64:
 	ret
 
 .size call32_from_64, .-call32_from_64
+
+.section .note.GNU-stack,"",%progbits

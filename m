Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122832D8F92
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbgLMTBz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:01:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46644 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgLMTBu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:50 -0500
Date:   Sun, 13 Dec 2020 19:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ioqWbLtfgzyASVT8t6YeJ1VfjgW0TsH3AGUfj13WTiQ=;
        b=WGIfXH0qbaRga5fs0D6VLw2oUFeHWn5ja+OrgdDA4/2ZoivYBqZq2J+m4e9a0s+Qvr6Bq6
        xOTBweL7rcK1GZZrkN05fOZVTuhdrjQvKwzZs9ExH5rsC8UMCWGNp1guIDt1nHicT9hB20
        xHeghQf3mqoaea5cVDXrdpagsIoy2u7M+QtRcCIXfLUgp3KCsR4twXiQHTJrC/qzrubHTp
        53nTKeRQ2EsoXdy7WwDbgi+YeFJPF711JtU2gIz62ioJC9FJt7TYHdoZ6SRLQqh3ql2B3n
        F4d+9YVIpyM7zoavwgsyibaqrvUJDHyWJvNn+e+H8bb71ImQLnclnbwoGcTtfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ioqWbLtfgzyASVT8t6YeJ1VfjgW0TsH3AGUfj13WTiQ=;
        b=jPnJW+wxGiSNyFm8U87POlmrp+xvrKLG1TMX0SjlI7IxGPdLhq/Fnia7KWIURSYsI2Q7Jt
        1HwlQtUiXeZFaiCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Force weak-hashed pointers on console log
Cc:     "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606853.3364.18172340506904894589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c1e06287583e5ec496e4c02bf5b319e5e41a1fd2
Gitweb:        https://git.kernel.org/tip/c1e06287583e5ec496e4c02bf5b319e5e41a1fd2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 21 Sep 2020 13:18:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:54 -08:00

torture: Force weak-hashed pointers on console log

Although the rcutorture scripting now deals correctly with full-up
security-induced pointer obfuscation, it is still counter-productive for
kernel hackers who are analyzing console output.  This commit therefore
sets the debug_boot_weak_hash kernel boot parameter, which enables
printing of weak-hashed pointers for torture-test runs.

Please note that this change applies only to runs initiated by the
kvm.sh scripting.  If you are instead using modprobe and rmmod, it is
your responsibility to build and boot the underlying kernel to your taste.

Please note further that this change does not result in a security hole
in normal use.  The rcutorture testing runs with a negligible userspace,
no networking, and no user interaction.  Besides which, there is no data
of value that can be extracted from an rcutorture guest OS that could
not also be extracted from the host that this guest is running on.

Suggested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 51f3464..8266349 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -169,6 +169,7 @@ identify_qemu () {
 # Output arguments for the qemu "-append" string based on CPU type
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
+	echo debug_boot_weak_hash
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)

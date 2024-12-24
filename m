Return-Path: <linux-tip-commits+bounces-3129-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832D9FC168
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 19:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802991884B4C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6B2135AC;
	Tue, 24 Dec 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hqocyzz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3oqadym"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C018B213223;
	Tue, 24 Dec 2024 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735066427; cv=none; b=IBvbzvOfIYl7QHtCWmu8AKwJFY9p+xLyvMEXYSWuMMzp1InFv+1HqNsCVVDTAMJUo/kQwDSApFk07ZymIM6c2Y5KuTnQjMSIPfv5ntqGzaW84EVpGIbAfj11XyL2QTNXhcnbew01zlh3OfDlLf9zFVcvZCOW0vqSQmHFElIw4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735066427; c=relaxed/simple;
	bh=N/MdBT7U/sg16HHihJIAFyoR4vdcmcDmtbsSUwxOUNQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Binkx6SbwJlD2v382XF6Go5dlzd/btkXnISAHCXRrlmYAHSvRtRa/Th9gEeIqSgLpmrFxkjXko3V+DPc+PxXW2o6PjEJQwrHUflLRF3k/lust24jtWIIGk8ZhW9Im5NVBzmVSWBx67NMHFs3QmBvhs+1FpgK/jU7UKitmFDalfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hqocyzz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3oqadym; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 18:53:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735066423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7Fg+pO6K8ayA3TqjuPuyylipi8UZwB+wYjRtkHyYnsk=;
	b=0hqocyzzPq3vFDmo57UgUio/y5wrYv6wFAW5BzCGACNakCiaaEJDnHpTocnJqmSh/nPXCC
	4iBM0R7tMrcy91Vwaz6v3ws1J1B3Gr5qEnrQDtV6q14RPpnFSlp6ROYevfcp9zgAqzbXao
	3OhBCOelHuN2O/jQ0YLGvCQAMKe6/95NmmB6XLUqvRwjmSeYx4SduJkBeRlcEQmLmmZ2Tw
	aWFC5AX98OvBlcLeGfknda1O0kapCAFJnoksW07METDqngTimSaHIcOxeog5BAQuECN0Qg
	FpPzUyJO36VAgJz7VUkIbchKRJWfEtnLrWbXomvFVgaF1GC/WF1+VF25touIeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735066423;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7Fg+pO6K8ayA3TqjuPuyylipi8UZwB+wYjRtkHyYnsk=;
	b=n3oqadym+Egiz/XPIbbI18Fapj9fbW78evvHXPUbWVJxqaAwjfbwlFa/5raUdm4sxPYQAp
	lzfGVy9t76RhcRAA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: MAINTAINERS: Start watching Rust locking
 primitives
Cc: Miguel Ojeda <ojeda@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173506642258.399.16974577371429551132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9793c9bb91f1b05473bb6d4a2323a259ef00ff2e
Gitweb:        https://git.kernel.org/tip/9793c9bb91f1b05473bb6d4a2323a259ef00ff2e
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Wed, 27 Nov 2024 10:30:24 -08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Thu, 19 Dec 2024 14:04:42 -08:00

locking: MAINTAINERS: Start watching Rust locking primitives

It makes sense to add Rust locking primitives under the watch of general
locking primitives maintainers. This will encourage more reviews and
find potential issues earlier. Hence add related Rust files into the
LOCKING PRIMITIVES entry in MAINTAINERS.

While we are at it, change the role of myself into the maintainer of
LOCKDEP and RUST to reflect my responsibility for the corresponding
code.

Acked-by: Miguel Ojeda <ojeda@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
https://lore.kernel.org/lkml/20241128054022.19586-2-boqun.feng@gmail.com/
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7..e049570 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13423,8 +13423,8 @@ LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Will Deacon <will@kernel.org>
+M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
 R:	Waiman Long <longman@redhat.com>
-R:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
@@ -13438,6 +13438,11 @@ F:	include/linux/seqlock.h
 F:	include/linux/spinlock*.h
 F:	kernel/locking/
 F:	lib/locking*.[ch]
+F:	rust/helpers/mutex.c
+F:	rust/helpers/spinlock.c
+F:	rust/kernel/sync/lock.rs
+F:	rust/kernel/sync/lock/
+F:	rust/kernel/sync/locked_by.rs
 X:	kernel/locking/locktorture.c
 
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP/Vista Dynamic Disks)


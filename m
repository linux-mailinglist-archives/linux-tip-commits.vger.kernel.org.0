Return-Path: <linux-tip-commits+bounces-4746-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD83A7F772
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD9118996E9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2751F263F5E;
	Tue,  8 Apr 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ss3dYONB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uHZvJNs3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3B263F23;
	Tue,  8 Apr 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099945; cv=none; b=AXUbzqTMd/WVErrad7XDEmxFQrbshjaU778iU8iQSe3tq8QEAw8c0fBe2E8H0OnrRDUTB7+hQivDmoWwX3XMYdNMGXjRI6SlsIvt6zYh2MN9Ixcko6UnciD4g8KXWPtZBuRbE00TdG2Xs01Mfu5ObH1rcGn4cz5A5YyJyOxgqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099945; c=relaxed/simple;
	bh=06seFx7k3BNlphlhTX0uBu7X2wZe/CuK4ryc5063EX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B1giifYt1d4/gqMr1/gPof/SfwoFGetMH8xbCfvB5Z+WesAYM4Q4d1TfAXkKuzMcyZ2Ove1tXD7VGdAiv1bmCAAnDeP+UKknbbFObapQ7FrB5bcfsLPC374bUkEW1ApxBca+cEQACzoOK30AVPDHY7+EokDzhnPAs+QZw5FkrVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ss3dYONB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uHZvJNs3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 08:12:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744099941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUHzzfNdYsMzpzypkJkPSgadEDRfQIhKGULFIj6LKso=;
	b=ss3dYONBR3kOUS3WIl1HpK6io0eaRcS4JkZvUTauImxx+sp36Ba7a2N63mBde7V5Vq+2ne
	r1v5LilCARbzX3enJBa2Q8Bf9rbDbxudzvW33iw76kkfPjNCp15WdrP5SNGoKHlwMb0j1D
	uqZENGWvKBSRBUxaBD4hSAF34LvHLE5p7TCUzANlw+Rfb8h0zefssd2oKXVxop/0xH2Xfo
	HFbLMlbHD64lyyEMDpSAL7aummcpP+ZI8y4BDKmsAN4dJZEAGoVOEb6m7pSOOh7odMu9qC
	KPbRu7iYkxyqJtZHk9fkrqsN4DyOj+zpXjMPV+a50FKJtydLfio0Ti3YpCyXyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744099941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WUHzzfNdYsMzpzypkJkPSgadEDRfQIhKGULFIj6LKso=;
	b=uHZvJNs3kOh+6Pcv3cbY9uij7xo3MB3QyJoCi2KyRP8qLa+yigJAQdJTDTUd+/dhfXm331
	sLU1Apx0SnU3L7Bg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix INSN_CONTEXT_SWITCH handling in
 validate_unret()
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <f5eda46fd09f15b1f5cde3d9ae3b92b958342add.1744095216.git.jpoimboe@kernel.org>
References:
 <f5eda46fd09f15b1f5cde3d9ae3b92b958342add.1744095216.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174409994098.31282.4830296640824754094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     a8df7d0ef92eca28c610206c6748daf537ac0586
Gitweb:        https://git.kernel.org/tip/a8df7d0ef92eca28c610206c6748daf537ac0586
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 08 Apr 2025 00:02:13 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 08 Apr 2025 09:14:11 +02:00

objtool: Fix INSN_CONTEXT_SWITCH handling in validate_unret()

The !CONFIG_IA32_EMULATION version of xen_entry_SYSCALL_compat() ends
with a SYSCALL instruction which is classified by objtool as
INSN_CONTEXT_SWITCH.

Unlike validate_branch(), validate_unret() doesn't consider
INSN_CONTEXT_SWITCH in a non-function to be a dead end, so it keeps
going past the end of xen_entry_SYSCALL_compat(), resulting in the
following warning:

  vmlinux.o: warning: objtool: xen_reschedule_interrupt+0x2a: RET before UNTRAIN

Fix that by adding INSN_CONTEXT_SWITCH handling to validate_unret() to
match what validate_branch() is already doing.

Fixes: a09a6e2399ba ("objtool: Add entry UNRET validation")
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/f5eda46fd09f15b1f5cde3d9ae3b92b958342add.1744095216.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4a1f6c3..c81b070 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3886,6 +3886,11 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 			WARN_INSN(insn, "RET before UNTRAIN");
 			return 1;
 
+		case INSN_CONTEXT_SWITCH:
+			if (insn_func(insn))
+				break;
+			return 0;
+
 		case INSN_NOP:
 			if (insn->retpoline_safe)
 				return 0;


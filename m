Return-Path: <linux-tip-commits+bounces-6901-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F286BE2963
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C772503E46
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9D3375BE;
	Thu, 16 Oct 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="29abKyiA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p4fsWqs9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20D32ED36;
	Thu, 16 Oct 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608398; cv=none; b=leXwCwARoi7+V0z/UpCXVR9/Ne2z/oGr9bLpEDtzaMLgTgkjAgJ1zOETvPALArsT7Yt+lnlbACQ8mv+kY4mmCCs3xPYP3RBMpjpdDHVG7teBfIGsiZX6tRLuKlQ+NES6rbkJ6U95XtUEzJC7eyQXgsk+ZhAbiPJDqCwWF4vTofc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608398; c=relaxed/simple;
	bh=iSD0u4qTQk+90UupQz/7hF6KQH3hlnl9RKuhsmJ7GW8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RhudDHwNvS8ci2d5RtLXJXPn9MHQwFwMnCG1ufGMklrtCTa5IhzdsvaEo9dXTAiUibnyHAb+tyqNNxWuHcpRkIp3cnzN8a162XjocG27pYKUwe6+YJjoxH/V2PHpDCc0S56jjalL9k6Ebq0T+O8YE/XW7SjCFCWxl4V35zFpJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=29abKyiA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p4fsWqs9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gjhocAYBUux19YJesOhoM++unQ5teanaii+jzvp5kr0=;
	b=29abKyiAkG7MhacCrwiF1REK+98SsU/VrNu7E1K0w6uJRGssK9B0OJG8QlP8Z+OvkSJ6qr
	l0wWymx1aWazlsh/ulvVheHchn37krqgpUkrGxn52Mc2qIoaOjLxnZDX6ZkKkScmp+T8rT
	rOCmOV42KvFXYy4zgeAb/o6wbeTQT2TWmASpN/X0Mert4k8tmPi4dGKlfPeDsZZKyQ5DAl
	wbueK7Hd717Hz671+BvD+zQnH9o3lhcKu49uQ6NXSYQtLTy4WXMQNDD+V13oPiOf49Snkl
	yDBjwFD6jun+NvB9y4Fmxdd3rRm63t1fPC+BbnXeoQmpjHPqQkMk5drO1HyjPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608376;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gjhocAYBUux19YJesOhoM++unQ5teanaii+jzvp5kr0=;
	b=p4fsWqs93TVytxTx/hD82OeivHdpWAYZdCsaMgGCzw4gQKpJC5dqINjozLYQ+VSA9eYr12
	qDEU0QtiSvUsARDA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix __pa_symbol() relocation handling
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837492.709179.2612593450554422928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     68245893cf447cca478e6bd71c02741656053ef4
Gitweb:        https://git.kernel.org/tip/68245893cf447cca478e6bd71c027416560=
53ef4
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:29 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Fix __pa_symbol() relocation handling

__pa_symbol() generates a relocation which refers to a physical address.
Convert it to back its virtual form before calculating the addend.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 6742002..b10200c 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -68,6 +68,17 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
=20
+/* Undo the effects of __pa_symbol() if necessary */
+static unsigned long phys_to_virt(unsigned long pa)
+{
+	s64 va =3D pa;
+
+	if (va > 0)
+		va &=3D ~(0x80000000);
+
+	return va;
+}
+
 s64 arch_insn_adjusted_addend(struct instruction *insn, struct reloc *reloc)
 {
 	s64 addend =3D reloc_addend(reloc);
@@ -75,7 +86,7 @@ s64 arch_insn_adjusted_addend(struct instruction *insn, str=
uct reloc *reloc)
 	if (arch_pc_relative_reloc(reloc))
 		addend +=3D insn->offset + insn->len - reloc_offset(reloc);
=20
-	return addend;
+	return phys_to_virt(addend);
 }
=20
 unsigned long arch_jump_destination(struct instruction *insn)


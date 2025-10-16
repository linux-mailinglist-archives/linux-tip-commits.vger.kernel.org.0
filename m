Return-Path: <linux-tip-commits+bounces-6916-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA72BE2986
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5E34FFA05
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8833A021;
	Thu, 16 Oct 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dvDiMoGW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6eT5gfCU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382A3314B8;
	Thu, 16 Oct 2025 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608410; cv=none; b=i6u2cmsui52bthpjpz+WN+SLqouOOiNTDcKjFXTSl1KaYs1pFJ1fPgUMOtoGpTtu6qkv4bP3qj70tkK5ulNYOZVbck4Ico5nqTDKs1S5LUgQfbiH2R/5V0FMZSDmw+6YRg6wp6RnqrrAo0myiPM1AagO98vGhqxZRRUBZiyoKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608410; c=relaxed/simple;
	bh=ZMzfM+WeaBdt88pysCbNeGdgk8YLIAjUjZhVfujRIQ8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Bn3S5spM0g8AWe7pxeOIetT7KXYAjw3491khvvcRjlFNKgGBnl4Gio3x23xQd8gkLFmfJ5pR4EPfaf4q9q29TdcRBXQLQ/yl9ZGf23v4uglqKXPaR/nxx9Q0n75IMCb/3i8wEAQ2AffEXO809ZsDRRxRIBsC7anrz7PVmxj4WW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dvDiMoGW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6eT5gfCU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kIIqzz2dlDxNkl5lYottJdNJJf7YjtvI4T9XdmalDWo=;
	b=dvDiMoGWuIjx+VP/kFbE5tgaKXpbZf02HfCajsImIoDrBU1auP4yWc1z5hOFiN7XdfHVnL
	L9sqEimvJlf5QAUjxiDMXCwqsH2LHyypy8zbiGvclJoQXE6EanjaxdTIdF86CRsbpyfu7V
	0uFu5/wuGmuBu5JAOpZ9RTjfXpGyYcPCOGlgJMoPHDUhlTbASO0TJXuAn9fm2fkD7DRkCv
	xYH0xaA1pisz1l2Q6Oik6zEzmkAznKjusCbf5cvQ6pOvNhdv1Hg7+TiGnmn0VvxqIqSAdi
	/yE+/M8lGANLrtddt1fPCP3Cw9QIu64jdsUYYzBnYfegkWDSu2u4yendfEqCkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608400;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kIIqzz2dlDxNkl5lYottJdNJJf7YjtvI4T9XdmalDWo=;
	b=6eT5gfCU9e5dJzZDu80A+zRhzLHPSTWnaK3gd1AXgpbFlT3fVvd8IYXxbjb6VJnluyoF8u
	oaDbbyStnUmQWsCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] s390/vmlinux.lds.S: Prevent thunk functions from
 getting placed with normal text
Cc: Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060839926.709179.1306478390979270982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     68e71067ec9ad08e1e51c06123a155d0814aff7c
Gitweb:        https://git.kernel.org/tip/68e71067ec9ad08e1e51c06123a155d0814=
aff7c
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:09 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:21 -07:00

s390/vmlinux.lds.S: Prevent thunk functions from getting placed with normal t=
ext

The s390 indirect thunks are placed in the .text.__s390_indirect_jump_*
sections.

Certain config options which enable -ffunction-sections have a custom
version of the TEXT_TEXT macro:

  .text.[0-9a-zA-Z_]*

That unintentionally matches the thunk sections, causing them to get
grouped with normal text rather than being handled by their intended
rule later in the script:

  *(.text.*_indirect_*)

Fix that by adding another period to the thunk section names, following
the kernel's general convention for distinguishing code-generated text
sections from compiler-generated ones.

Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/s390/include/asm/nospec-insn.h | 2 +-
 arch/s390/kernel/vmlinux.lds.S      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/nospec-insn.h b/arch/s390/include/asm/nosp=
ec-insn.h
index 6ce6b56..46f92bb 100644
--- a/arch/s390/include/asm/nospec-insn.h
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -19,7 +19,7 @@
 #ifdef CONFIG_EXPOLINE_EXTERN
 	SYM_CODE_START(\name)
 #else
-	.pushsection .text.\name,"axG",@progbits,\name,comdat
+	.pushsection .text..\name,"axG",@progbits,\name,comdat
 	.globl \name
 	.hidden \name
 	.type \name,@function
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index d74d4c5..8609126 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -51,7 +51,7 @@ SECTIONS
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
 		FTRACE_HOTPATCH_TRAMPOLINES_TEXT
-		*(.text.*_indirect_*)
+		*(.text..*_indirect_*)
 		*(.gnu.warning)
 		. =3D ALIGN(PAGE_SIZE);
 		_etext =3D .;		/* End of text section */


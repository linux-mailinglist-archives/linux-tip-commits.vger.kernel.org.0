Return-Path: <linux-tip-commits+bounces-6908-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D344ABE2933
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02BFA354D19
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06379322C78;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pwL5v8DR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60MU3CQt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C45330D5C;
	Thu, 16 Oct 2025 09:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608405; cv=none; b=PUQVXLqJ79vsK/ZbQvXoCbyzUOth5FKiTqMaTm3lHhUNoV3XBdf8yKnfm2ArY5qmdfEHTVBlHTMVuwPq8xe46fLBtGKcFYaMoy9H6ICBHGSDYXoiR5DpDsf8R4IhhzSHebdbr3yr0RojqIuPUTxRz4a7Bq4lS8rolz7vK9l7b0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608405; c=relaxed/simple;
	bh=DSPNI5Kk1VQHF+dvAdXXfAD4Jjr/YPRf9rzEIpIKONU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gCeKGskTmYI1tXODtr0TvD72fXDZLewGItuUIp6TH2LuK0uaqOHFwCajqeMI/x7LYOPyqa21fTp7223I+RyC4LBxAkOzUbTXCwn8UB8RhbB5I6YdezxSYXIcYgHpv8gN0Anv0f35tsMktp6FFlfZehory9ompBfrZDCDMTRiTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pwL5v8DR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60MU3CQt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Iw7bJBjZG6mCZRgn+/UmJzaV54kQNIXLWkUNIpfIqu4=;
	b=pwL5v8DRsP9fLp3J+pCGN9bfsnsi5IQNJKqt8m7V9Bwr0TnwOykpK5M40b1tvQunY6Fnrq
	HZHvIEBGWRBAJxhF7fQqkZgvkaFxtHpyapElBTaAVHXy1b+6v1K/uKzi/5KFJRg08eEc5j
	Uy10eBLjeiV8kmhP9SaWzCdD6GPIuhd0voWkFWrWeThEFoQVr5sk8upkt5ZkDkJHbrW1Wq
	60uF08d1zBPe/+XYG5SKKvBuNHLe1bOa0Vhi1tItIDKTE05r0vDhlHkt6If+TTVGTJGG7u
	d0BowMZOExM0s6/BQT72Kl5XX82AjHoFaVorsoLR+jIR3nQG0OHdZ6hFV7RKag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Iw7bJBjZG6mCZRgn+/UmJzaV54kQNIXLWkUNIpfIqu4=;
	b=60MU3CQtVcp3e0HqEvvXBvxZQNX84rbq48KknRBXcn3usa5SD7Puk6MW3X4VbNbHt8pcz6
	WtvGAAr3qPeHKRDQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix interval tree insertion for
 zero-length symbols
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837854.709179.11271350158148453381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     c2a3e7af31107a2e1dff92b0601d525466dc21b7
Gitweb:        https://git.kernel.org/tip/c2a3e7af31107a2e1dff92b0601d525466d=
c21b7
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:26 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Fix interval tree insertion for zero-length symbols

Zero-length symbols get inserted in the wrong spot.  Fix that.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index a8a78b5..c024937 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -92,7 +92,7 @@ static inline unsigned long __sym_start(struct symbol *s)
=20
 static inline unsigned long __sym_last(struct symbol *s)
 {
-	return s->offset + s->len - 1;
+	return s->offset + (s->len ? s->len - 1 : 0);
 }
=20
 INTERVAL_TREE_DEFINE(struct symbol, node, unsigned long, __subtree_last,


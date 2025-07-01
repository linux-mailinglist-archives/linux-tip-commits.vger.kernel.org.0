Return-Path: <linux-tip-commits+bounces-5963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97164AEF9FD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 15:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505EA3B1C1D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163AB26FD8E;
	Tue,  1 Jul 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRk5eqrY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fSf6Ko16"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AE526E6F1;
	Tue,  1 Jul 2025 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751375637; cv=none; b=JeZ7QzKVL4OSCik9e+h2B+XXusxXrAcN5ehjwqMQugVQQ2wPZatT4z/Y0+resggRCNcpgUnrTSzCnBWujSSkV4ByxHsoUhwj+miYjud+3LjwjAPT85TYwwnOEIwwC1/R6ZBjVcb19UNjynEiYd6I8CHCRWN6R0iZgJBtqOQ4iLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751375637; c=relaxed/simple;
	bh=kt4fZzanv5xynkKpz7PiMUXYLDom31BolNA3hRXpcw0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aoZDBBBuWD+V4YuNhKxFJoe0Ki2NVKNjAUozTT/g+0FpN3b8eMBF+Vk78msk2Tx8ORXWkkp4A21kmIw2Eh+rd92TkNiFob1mn+9G6IMb99ybs7NBAUQWqQfcs8iy2HjWXMt7Z+WKrHyRhkaOSOQDkO71qonMyZHV61JhhW0nQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRk5eqrY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fSf6Ko16; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751375634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXWlzwR4gtdD31vgnLVfx/H2PcB8dGQ408FdavLjdhM=;
	b=dRk5eqrYGvHsfOgr9foXY8E/1CiZbAYK3adQ5qnykV92okxghp2LVWnamRbcwVKqlnHFwe
	OTLXSRIfjashiwU6R/eXap5E8fRD1gRghiV6YhHYvyWEu1rxrst5nOHw1pjnE0dX7Cs8/C
	z1Bkwnp8/EywEO5nP4G8RO8RiNzPEzEP7coR77IgJw8ODC8glMbqnVXNWT4PYHWDXsBVut
	pXLRxC80KXTxRgHQ6zcU6eLWlQ0EbnoDc9ov2mCrk5BQU0XVoKf6a3M1vHFzikXPvKJQEg
	6YJbjArAWG92vIaliEzKr8H6biCIV95sDe42jPp7/Zm8uFXnI8QWOBkb+eEKIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751375634;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hXWlzwR4gtdD31vgnLVfx/H2PcB8dGQ408FdavLjdhM=;
	b=fSf6Ko16etUPKABLO3SiX4QscpPprjAnJBPY5rVeSsx4wRCEemhcAwgKG4m95PUYHOoa56
	gozenT7Hw1ZDmzCA==
From: "tip-bot2 for Heiko Carstens" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Add missing endian conversion to
 read_annotate()
Cc: Heiko Carstens <hca@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250630131230.4130185-1-hca@linux.ibm.com>
References: <20250630131230.4130185-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137563313.406.6298042704364318030.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ccdd09e0fc0d5ce6dfc8360f0c88da9a5045b6ea
Gitweb:        https://git.kernel.org/tip/ccdd09e0fc0d5ce6dfc8360f0c88da9a5045b6ea
Author:        Heiko Carstens <hca@linux.ibm.com>
AuthorDate:    Mon, 30 Jun 2025 15:12:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jul 2025 15:02:04 +02:00

objtool: Add missing endian conversion to read_annotate()

Trying to compile an x86 kernel on big endian results in this error:

net/ipv4/netfilter/iptable_nat.o: warning: objtool: iptable_nat_table_init+0x150: Unknown annotation type: 50331648
make[5]: *** [scripts/Makefile.build:287: net/ipv4/netfilter/iptable_nat.o] Error 255

Reason is a missing endian conversion in read_annotate().
Add the missing conversion to fix this.

Fixes: 2116b349e29a ("objtool: Generic annotation infrastructure")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250630131230.4130185-1-hca@linux.ibm.com
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f23bdda..d967ac0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2318,6 +2318,7 @@ static int read_annotate(struct objtool_file *file,
 
 	for_each_reloc(sec->rsec, reloc) {
 		type = *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsize) + 4);
+		type = bswap_if_needed(file->elf, type);
 
 		offset = reloc->sym->offset + reloc_addend(reloc);
 		insn = find_insn(file, reloc->sym->sec, offset);


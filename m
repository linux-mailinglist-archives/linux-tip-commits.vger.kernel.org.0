Return-Path: <linux-tip-commits+bounces-6882-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE99BE28B8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0298C1A627BE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1790B31961B;
	Thu, 16 Oct 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tiHq0Pwl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="To8SCsJg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F423203BA;
	Thu, 16 Oct 2025 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608375; cv=none; b=q3vckL3RzNNf7Yx0EH2f8bzn6HD4T3fzRYcILBxcyBcPArkhuQaSV6doivk6e3Wc58OIgqP4RjirEkpvFSBccaJM+VVVu+3PkcEWhTkK3cIiTcdZFTGEJx42RMaqIDDRHCcbVAqVQ+JOheFCWdIUERPLYzaneZFyDYbrIH7nrSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608375; c=relaxed/simple;
	bh=k9oWBhK0sdp+zAQlAlCEC9fI7udDFe4gu70fy14fOwM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=aK5Wg9krBZWvPGUnCulyayUOFIlBC6DEUx1Y9w9uKcXalEhSss5YW12dh5j6gZowiYsekRjgUf7bWZUbK6NBLX+2eurDz/W7a0zN+2T3gSSf9/VkT/HHarENTZSDj9eFx7Md8s9vYNnRfeuuDooL7kCs0P8uM4Ski1S0wspYykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tiHq0Pwl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=To8SCsJg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8spi4ZZoxTLEt20QX8jkXbOPzryYGlAbJRAsZQtAvZc=;
	b=tiHq0Pwlh/gf976J9z1SnaukD9MgkHPCYIgj73maU7uQkQW0YR/tuTT9qIJBbw2ZsyHACP
	aSGfwT/l+g6PL/xrzYLUBrkXvsNP7fK5Qo0C5M/7pbY4tNjD12X6Rd5VFZbX5xWtqvXJT4
	9aqQ0N31uxFYjvAImGMZt7g68AdM2Gjw0AN9dc/0CAZdL3qOZwtKnkCv/v4CAbm6paD4Wg
	GtJjfIrlMdY/Hb7cCrANbPh0NSJot9ILDm9SM0rUoklGfwwoUIUEVkGjoPws35X0jG+MEr
	zThACa8ulogHwzLk2Y9dGHUaJXLKf5DRgBGMxcinGnABcxBGKIME6S+q/TRFjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8spi4ZZoxTLEt20QX8jkXbOPzryYGlAbJRAsZQtAvZc=;
	b=To8SCsJg4Fcvs7cfPj8TU9+LrwWaHDFd3R9HDELSypV0P6N/RN9MxYhyYhxQwk4+vZLzt4
	LA4Mm5RcYn9rVoBw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Simplify reloc offset calculation in
 unwind_read_hints()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836098.709179.6667413757176463412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a040ab73dfd1bc8198848a438f77497d8d03fba9
Gitweb:        https://git.kernel.org/tip/a040ab73dfd1bc8198848a438f77497d8d0=
3fba9
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:40 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:47 -07:00

objtool: Simplify reloc offset calculation in unwind_read_hints()

Simplify the relocation offset calculation in unwind_read_hints(),
similar to other conversions which have already been done.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c |  9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 46b425f..473e737 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2200,14 +2200,7 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}
=20
-		if (is_sec_sym(reloc->sym)) {
-			offset =3D reloc_addend(reloc);
-		} else if (reloc->sym->local_label) {
-			offset =3D reloc->sym->offset;
-		} else {
-			ERROR("unexpected relocation symbol type in %s", sec->rsec->name);
-			return -1;
-		}
+		offset =3D reloc->sym->offset + reloc_addend(reloc);
=20
 		insn =3D find_insn(file, reloc->sym->sec, offset);
 		if (!insn) {


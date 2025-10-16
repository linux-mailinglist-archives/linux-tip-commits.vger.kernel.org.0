Return-Path: <linux-tip-commits+bounces-6911-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDBCBE297B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC8B64FBC20
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71E338F57;
	Thu, 16 Oct 2025 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BN2o6r5P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jfNYhBzB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAED330D48;
	Thu, 16 Oct 2025 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608406; cv=none; b=DA+uhNHHPUIVOHl77DnHdjWSOCr2B6pu52hK8GzWtN5ViR9DN2P/sQlKi6w8Yfh7mJsXUWQx4Sdb3ll1yM6Tj2d3V+pDNVuYtpHySoRd+1GBAZT441oVBpLPWg4wDIy/NvJBkalfCqfwqlvwOvYdJi3LjNdpVaOuqPqMuimP/4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608406; c=relaxed/simple;
	bh=cx3342mW0W5PARNnYhZXFqYWqTgMvimlE5kHoTU2gIE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BUrMu8BrEPPRCPk9IJ7wIqEormUOBwwt8NuRNHQWvUVyTIK4u6dINySoI1EyVameHOT1uiyJVO0viG9zD+4ZLHe7r9cb+t0IcwH45+DGg54ZYUC2D1gyvpROetZNRiJmjpMtpD0zjS/hLNSob5lpvoHZdwu3CIU74Z0RBfLM73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BN2o6r5P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jfNYhBzB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QvHS8Rv4+yi1xrHpM24y3GDY7YiKu4O5R19q+x+5+Js=;
	b=BN2o6r5P3Eoslccy8LrHePpVLjY7hBmPAUXh8A6wASKeGv/mt78CZnKNNZAMHMPxQHYklL
	thmPW0plen+Yvzw8KQ148idCFEMEzzbmDKBXaW7shah3XRUzUp84Mj+Vma9GMa6y4Y/s/K
	CBjVpHFHxSDdSctq7sDPFRB93M9NimFjjkvUFKBaPMOMSwj98UFpsTJTmj/oRyZRSmmveH
	PQ4v0Yp1HJ4Fk0lRh3Q4vlbJp9LHU/Vw/hUvzD3CLHRaHhU0nfvn57s8rdvZZMggjbSa8z
	A5cY/CNSjoIAc7HSHrKWoCUERCFOFLrc6ATcAfzWYqjqnmvt0/BYektJ97TjPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608384;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QvHS8Rv4+yi1xrHpM24y3GDY7YiKu4O5R19q+x+5+Js=;
	b=jfNYhBzBlL7nzSN7ZeBiaG+eZVKYcMqBJFCOb7eRKatck7RZkVq+E9fovsUH8NZOv9NvQj
	HuFcs2a6FbEMlLBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Fix broken error handling in read_symbols()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838328.709179.13853867452101955806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9ebb662fab38a5942100e597b48de5ec9d5e714d
Gitweb:        https://git.kernel.org/tip/9ebb662fab38a5942100e597b48de5ec9d5=
e714d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:22 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Fix broken error handling in read_symbols()

The free(sym) call in the read_symbols() error path is fundamentally
broken: 'sym' doesn't point to any allocated block.  If triggered,
things would go from bad to worse.

Remove the free() and simplify the error paths.  Freeing memory isn't
necessary here anyway, these are fatal errors which lead to an immediate
exit().

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 1c1bb2c..b009d9f 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -492,14 +492,14 @@ static int read_symbols(struct elf *elf)
 		if (!gelf_getsymshndx(symtab->data, shndx_data, i, &sym->sym,
 				      &shndx)) {
 			ERROR_ELF("gelf_getsymshndx");
-			goto err;
+			return -1;
 		}
=20
 		sym->name =3D elf_strptr(elf->elf, symtab->sh.sh_link,
 				       sym->sym.st_name);
 		if (!sym->name) {
 			ERROR_ELF("elf_strptr");
-			goto err;
+			return -1;
 		}
=20
 		if ((sym->sym.st_shndx > SHN_UNDEF &&
@@ -511,7 +511,7 @@ static int read_symbols(struct elf *elf)
 			sym->sec =3D find_section_by_index(elf, shndx);
 			if (!sym->sec) {
 				ERROR("couldn't find section for symbol %s", sym->name);
-				goto err;
+				return -1;
 			}
 			if (GELF_ST_TYPE(sym->sym.st_info) =3D=3D STT_SECTION) {
 				sym->name =3D sym->sec->name;
@@ -581,10 +581,6 @@ static int read_symbols(struct elf *elf)
 	}
=20
 	return 0;
-
-err:
-	free(sym);
-	return -1;
 }
=20
 static int mark_group_syms(struct elf *elf)


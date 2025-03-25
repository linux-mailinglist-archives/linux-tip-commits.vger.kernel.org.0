Return-Path: <linux-tip-commits+bounces-4463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE98A6EBBF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3644816BDAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340A5257437;
	Tue, 25 Mar 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JUaYgVol";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AcRzNqrm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4442571D6;
	Tue, 25 Mar 2025 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891712; cv=none; b=YHHrwmSeJHH/FFm2G73ofP52gjg8ccD56sgr5BHvZ2GoF6cZF+Rz6/nNEuiM7LWBwZ5voVDP1votNtDQCWHS3nJgaL2/8/LqyhQOkqAI7+J91gl1uAFkHxlCpU50LXRR28zR1fnA6Dt2cVRZj0ep1f1EWJAdL6L7fUqoC6VP+Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891712; c=relaxed/simple;
	bh=47eK5Fa7361cBjwk8jB3w3uXu8xgy+fGOxCraAukxtk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SuT20rsMHW9AEJZA26YtsMD2bGYlEgZrszn8eMHFTPf2Y2JuYq+w8YRTF7jfo63KeudQIsauuTo8kvgGcGMpmoGQmjEuQ3JeXzOl/uA5W4L8QnFXXsJa8rVGaC/Rc45BJg11DKsXevxnjKgICc2CyJTK7Urd6/KY0sB+4NtV5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JUaYgVol; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AcRzNqrm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbqtxFuBSoweHsZ/oM/e5OhmW352jmP/YEG7uf08FSk=;
	b=JUaYgVolH2PSvtdZmYHFHCNliTqKXbB+8C+xcbceOCcRD7EaS66nMQdPXErRia2jipBTWV
	fThqmRmXGXURnQiYmPDFRc6ebU3l3GcTQ1WTEGit8f9YBANPwohxAL/SREC7SHJDdK4TzO
	MRDrPkIOJjSNThhXVwIIJj0w8nGMG7Gi3V9SkGpGXQ4O00iyCAVCGBSDMciDev7ZYE7wtt
	5vwMppZ+SYijkUDOMev5ji2YYGc/dsgWc4sT/AeaoL2NKjtof5E0tVSM08EWt3DT1Jyn1f
	9Ke4CuAbisaOu8nkATUv/KCnjOgpoP+qsfaItl1M1xJOaIgWPxYMlIT+32C90w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vbqtxFuBSoweHsZ/oM/e5OhmW352jmP/YEG7uf08FSk=;
	b=AcRzNqrm1URgrhZEaH7siyAqpX6ruFrtfp4n6dEmagd0AF69pg3SKSbXoVd+9K6bJrhkrz
	/iiEIt4rXn+MVSCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix init_module() handling
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <366bfdbe92736cde9fb01d5d3eb9b98e9070a1ec.1742852846.git.jpoimboe@kernel.org>
References:
 <366bfdbe92736cde9fb01d5d3eb9b98e9070a1ec.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170781.14745.11187264429697784200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     4fab2d7628dd38f3fa8a5e615199350ecaeb17a8
Gitweb:        https://git.kernel.org/tip/4fab2d7628dd38f3fa8a5e615199350ecaeb17a8
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:56 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:26 +01:00

objtool: Fix init_module() handling

If IBT is enabled and a module uses the deprecated init_module() magic
function name rather than module_init(fn), its ENDBR will get removed,
causing an IBT failure during module load.

Objtool does print an obscure warning, but then does nothing to either
correct it or return an error.

Improve the usefulness of the warning and return an error so it will at
least fail the build with CONFIG_OBJTOOL_WERROR.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/366bfdbe92736cde9fb01d5d3eb9b98e9070a1ec.1742852846.git.jpoimboe@kernel.org
---
 tools/objtool/check.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b2f6a7f..2f7aff1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -828,8 +828,11 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 		if (opts.module && sym && sym->type == STT_FUNC &&
 		    insn->offset == sym->offset &&
 		    (!strcmp(sym->name, "init_module") ||
-		     !strcmp(sym->name, "cleanup_module")))
-			WARN("%s(): not an indirect call target", sym->name);
+		     !strcmp(sym->name, "cleanup_module"))) {
+			WARN("%s(): Magic init_module() function name is deprecated, use module_init(fn) instead",
+			     sym->name);
+			return -1;
+		}
 
 		if (!elf_init_reloc_text_sym(file->elf, sec,
 					     idx * sizeof(int), idx,


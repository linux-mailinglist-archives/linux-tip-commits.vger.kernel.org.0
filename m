Return-Path: <linux-tip-commits+bounces-6903-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E488FBE2966
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AC004FC175
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554C31B816;
	Thu, 16 Oct 2025 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d1NtqoIb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VNJQCueD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755732F761;
	Thu, 16 Oct 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608399; cv=none; b=bGB7yMqSI/U1vVqJrdJwu1c3sNQgsGsXBBb1GtIDTaP1RCxTk3q+Bkv+QpPhpU0VlNbDGWYqAX9Kk8gktf/ge9PbXsFLcTq6QyammDI1gS28+ZxYJaOmxHfeLXfVULNB67aOrsM3nWSghDm5RiiW3laX8PeAvdLN2yu4JhEcqGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608399; c=relaxed/simple;
	bh=Vl/lVOQsHSyG4smP2D2jQVBh1olIO3jqyDIlxeyMcDo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MffoJFB1Q8Fn9i8RzcXAOIY2/Z3SVFW9wI4sAb3yUkVU1/YPizqrlhAVtQClVfBI4c81bbHYDxOoDHC161NgH9JOmTQ9HEzYxDR+8hKJV0baSHBlobz3C0fCsZBO3K5ijCl/PHSoqBByPT/dZY0/prVUF3X3wX4VufgnXcahT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d1NtqoIb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VNJQCueD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608373;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ouLKCrBB22wbf2BfGoNGEdLcHWVn71qIBwSjlt54Vio=;
	b=d1NtqoIbnZ+PCCLMkTWagmKf3BTickTHmDiLfddYLQxUDJw17hqBN9Dr0YryzwJeQCQPQl
	g2XEri3FWl4q/+mk0hm9U7cWrkcNjf54a3hktn7/R2lkwY+jBqvyTRdEtKBixO7cENKhy4
	SWt7CSKrpIsJkay35v563mViMgKVBhVaQOHu0eGQTHm1jikDRNSyEIyq1iEKdNTCA0Ol82
	N7JtTzme4/Pi2NlMPhPt8nqeguTNc9WjqYoCE4ck2gZBLKQifO4xNNRTIn+Z5Qb7fY20jQ
	RL9Ncxfx6U+E0KMUy94PgNTk8Vj/YqmFKZyyVKxrMWXxiHBHT6oFjfYEwGi/8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608373;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ouLKCrBB22wbf2BfGoNGEdLcHWVn71qIBwSjlt54Vio=;
	b=VNJQCueDweIbTO6lfZ/C0XM86oLjeHvgzaQZCwrh3WQwUzRj7UwMd4+Ny/vyfcfPKgl1F9
	/+opUFWRtT4XOLBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Check for missing annotation entries in
 read_annotate()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060837240.709179.2691000475549798307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3e4b5f66cf1a7879a081f5044ff1796aa33cb999
Gitweb:        https://git.kernel.org/tip/3e4b5f66cf1a7879a081f5044ff1796aa33=
cb999
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:31 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Check for missing annotation entries in read_annotate()

Add a sanity check to make sure none of the relocations for the
.discard.annotate_insn section have gone missing.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2e46f9..49d2db7 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2293,6 +2293,11 @@ static int read_annotate(struct objtool_file *file,
 		sec->sh.sh_entsize =3D 8;
 	}
=20
+	if (sec_num_entries(sec) !=3D sec_num_entries(sec->rsec)) {
+		ERROR("bad .discard.annotate_insn section: missing relocs");
+		return -1;
+	}
+
 	for_each_reloc(sec->rsec, reloc) {
 		type =3D *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsiz=
e) + 4);
 		type =3D bswap_if_needed(file->elf, type);


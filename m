Return-Path: <linux-tip-commits+bounces-6899-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B4DBE29DF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DB74856B7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF25335BCB;
	Thu, 16 Oct 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlG71YWR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmHL2BFU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92C31D381;
	Thu, 16 Oct 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608395; cv=none; b=pApZcmyqoExERLLmyPKhAtzIx/g/bp3SMo2ELV/dd8mtr5Au0XrryiPJ6jTk4+00+c9OjLARVkG0Ou4YYefLBevVn+bXJAq05dPK4+UODl55f88tt20sKmxcB8agqGhEiwNPaY8P2TXUhxAop13/4m+SwqeYU6+COK5ybJpM+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608395; c=relaxed/simple;
	bh=coDK7OEYDk+CPw11qH4reGrLB574V7DU9xWpGTEzQuE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VK/iQIDQaaGdH2Jsg4nyLy8K+c53b7J6zoMPAhhSOQ6mu9L5u0k3Doz3ERmdYSGZY/aQmlLkOUrBhxcgTlcg3Yw02226dvZiLqQ/huJ9xc2oNrCZgspy1QRjGAn3CfCbRSGvYwr1c4oJ3vzJkmx/j1EBuP18WgkspHbAqzZkAKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlG71YWR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmHL2BFU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608361;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AYbq9QQsrrqJ7Mr7arULcQaf/+uyA400mklgKrYBXy8=;
	b=TlG71YWRDcolfSpZXol+9ce6p17CGWVySP2k884SJDUJuxdKx6vi/Z5u9BN7vQkaPM+Nzh
	G2gxKmTW311J+u8QPyPVNXksG25mL3TyRltQskcudU+nH1gtteRHtUVK8WAFYyfN5COC0T
	CPwBFhDcYGR5QcpAJnFqs/sDyrTR6squTSXOR0CKqnUGd1d072LqCxkutHdKih0dzelhJ1
	Ye8PmSVq1Zx4AmEr5WHEgk4QeEqB4q4Vj80pSrCwHuXOc/OsMbbvmnKmEJDvOXVrqI4ruF
	eXu+DwnBkJvx9u9DyvgjJTg0iDsBMSWaoDBoC1+SYlPB8MjP47/sQQuaQO75sQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608361;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AYbq9QQsrrqJ7Mr7arULcQaf/+uyA400mklgKrYBXy8=;
	b=DmHL2BFUwc9RNzT5nhT6AQrCwL3ngGtHDex9OodjWywO30Ujf8s5/onucB8F5bUJ70/b+s
	kM6fKPz+GFlRd4Dg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Avoid emptying lists for duplicate sections
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835975.709179.13295815351548015038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     48f1bbaf2655c8178249cf10f1a50fac0a72e467
Gitweb:        https://git.kernel.org/tip/48f1bbaf2655c8178249cf10f1a50fac0a7=
2e467
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:41 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:47 -07:00

objtool: Avoid emptying lists for duplicate sections

When a to-be-created section already exists, there's no point in
emptying the various lists if their respective sections already exist.
In fact it's better to leave them intact as they might get used later.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 473e737..e567a62 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -635,7 +635,6 @@ static int create_static_call_sections(struct objtool_fil=
e *file)
=20
 	sec =3D find_section_by_name(file->elf, ".static_call_sites");
 	if (sec) {
-		INIT_LIST_HEAD(&file->static_call_list);
 		WARN("file already has .static_call_sites section, skipping");
 		return 0;
 	}
@@ -851,7 +850,6 @@ static int create_cfi_sections(struct objtool_file *file)
=20
 	sec =3D find_section_by_name(file->elf, ".cfi_sites");
 	if (sec) {
-		INIT_LIST_HEAD(&file->call_list);
 		WARN("file already has .cfi_sites section, skipping");
 		return 0;
 	}
@@ -900,7 +898,6 @@ static int create_mcount_loc_sections(struct objtool_file=
 *file)
=20
 	sec =3D find_section_by_name(file->elf, "__mcount_loc");
 	if (sec) {
-		INIT_LIST_HEAD(&file->mcount_loc_list);
 		WARN("file already has __mcount_loc section, skipping");
 		return 0;
 	}
@@ -945,7 +942,6 @@ static int create_direct_call_sections(struct objtool_fil=
e *file)
=20
 	sec =3D find_section_by_name(file->elf, ".call_sites");
 	if (sec) {
-		INIT_LIST_HEAD(&file->call_list);
 		WARN("file already has .call_sites section, skipping");
 		return 0;
 	}


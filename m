Return-Path: <linux-tip-commits+bounces-6919-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBDFBE2948
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E43E1A62959
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6E933CE83;
	Thu, 16 Oct 2025 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ej1i5LQ+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2DeHOm2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B9320CBC;
	Thu, 16 Oct 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608412; cv=none; b=Au3KFHHVAeJ12vhJXz8Iqcc6giDvn+DI+iPXWOquaOBPF1yMXQgX44NKWkw6Y/E4kvRsHYeINSDFLpCBjG1hecZ8pghLHIHyF115B2HFVrkoHO2qSAg2HhM5df4bv9M4f3efuJKGWGxxXKE0iTqZiaxwBKE28owd0la0iS4sAnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608412; c=relaxed/simple;
	bh=vycvK3FoA+yFWkSiPa6LXJFADN3fKX8wh7xsnT+G4D4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tGuBXP9loAWSIEuWuNL+15GwnZrvzuZVSoA63zWFbRtWDOha6YfxB4Rf68+hniL1I4zaevygStqjj0kZCXsriDQ+1uxH2zafbC526Kah/LMXoxhwwTNmTD8pKo0br+c5M3nYDa1VMqL/tFpRuLZjrT1rSIJX71Kk0KQdfVMfb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ej1i5LQ+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2DeHOm2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=z5Pn+LCxyBOBFghxxucJny9JPrG1FlZRDNBzVdPxfuA=;
	b=Ej1i5LQ+lJHBcznXjXlBlqAro7ipMwJdL9hjJ7heTdxYYkq6Zh0AyHLOgvMprhcxKIotkK
	WAOtjiN5u1QSzuNh5N56ZzGBNx6vyf+Og7RILHcGakXyemN3npGU+7cn7QxfmNW3Jsh8ZW
	lx1I+2ZFeOG2vst+mS319bkxKcaPRT5wlt4oFlmtmB1pw7HrCMMXcbjyl1lgfZFMnM92R+
	L1uC3ZOCvn9qimK4LvG/kMy/bjItTNGx/adhr/5rSK09A1HKOk5QhZSLzry9xe+ZLDczdc
	ZhaMzEusVEPl1VBQSbLGFoOkSTLXZ3Y3qhRjtrvl9NxH7UCctwWTxYjfx6Cb+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608383;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=z5Pn+LCxyBOBFghxxucJny9JPrG1FlZRDNBzVdPxfuA=;
	b=H2DeHOm2BO3aukZZSAzKyppRPRKCSU0keol+ShtSEqK6xw2h5LdjLLVqm0tPFhbNZXkTp9
	dj4ikEV8DcNrq5Aw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Propagate elf_truncate_section() error
 in elf_write()
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838210.709179.8473939432428346422.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     2bb23cbf3f21919ba17cf63404ec0224bd8bf4fb
Gitweb:        https://git.kernel.org/tip/2bb23cbf3f21919ba17cf63404ec0224bd8=
bf4fb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:23 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:23 -07:00

objtool: Propagate elf_truncate_section() error in elf_write()

Properly check and propagate the return value of elf_truncate_section()
to avoid silent failures.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b009d9f..19e249f 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -1307,7 +1307,6 @@ static int elf_truncate_section(struct elf *elf, struct=
 section *sec)
 	for (;;) {
 		/* get next data descriptor for the relevant section */
 		data =3D elf_getdata(s, data);
-
 		if (!data) {
 			if (size) {
 				ERROR("end of section data but non-zero size left\n");
@@ -1343,8 +1342,8 @@ int elf_write(struct elf *elf)
=20
 	/* Update changed relocation sections and section headers: */
 	list_for_each_entry(sec, &elf->sections, list) {
-		if (sec->truncate)
-			elf_truncate_section(elf, sec);
+		if (sec->truncate && elf_truncate_section(elf, sec))
+			return -1;
=20
 		if (sec_changed(sec)) {
 			s =3D elf_getscn(elf->elf, sec->idx);


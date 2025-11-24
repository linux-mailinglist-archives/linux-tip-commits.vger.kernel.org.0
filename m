Return-Path: <linux-tip-commits+bounces-7486-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1FCC7F803
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 10:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3B43A2D5F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Nov 2025 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5362F658D;
	Mon, 24 Nov 2025 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUkO+Nc7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i47QXgov"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07A2F60DA;
	Mon, 24 Nov 2025 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975506; cv=none; b=bdm1Y/R5a2MCLHoknalQxh7nh+vNM5Hz7thIDiNZtUf9K5sR0NgBZv77QkHIW6BQXFjjxZBPlnekgepv9qcYFUDNB5y0ET4j5CaUT55VPdUhJYfJ/dtE54HQ0ixa+5MWSlg4Ia3/RtpFMS12Mqf5cUEjH7DzZM/5y++ukKiuOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975506; c=relaxed/simple;
	bh=UBEMjtnPQwbymazbL1srRajRm7CmC7smpmOWGbe/F9o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YVAsojmDauaL1MVLvxXatXGmyKs127i75vkK+ZJihq/G7sQtjd5cxIw5j1sopCyhQKScaDsacxGGlKxx2PMXBhhvs12DT1eFCRvrVeYHu91coqldfL5fITGXQ/Xy/W019CKj7Ze3W5FjKqRF18zKz01IjhJTkkWHr4eevqZ7vms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUkO+Nc7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i47QXgov; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Nov 2025 09:11:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763975502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzVduj64WwtY4Ft/U/eQf/i2Ugn3jVPwtZGr0hlDWEo=;
	b=cUkO+Nc7IoOhJLJeacGH/XaGDhrhFotWVW2LQYCiT44nglH5yEKk4hgSt3U+h9QaACQml3
	/Rvc32DwOVqA6uaFu81jyCl/Nf2DGw8bBXfUEKgf9qHIuzWnFPl6ukXvPVnubH+Fv2cXJu
	4wSXYNCFCVj5ipulTfLhwzJ+i2fC+QxEFM/Qv4YnARk/U6SeQwz1kqRacEueXl3cFWqg+B
	ITi9WXx0jhfkjF8gccZjbRAmZ8iTNk43ARkBB6H/BOyaTSKB4qwosBemxZ+jDhMiORDQqo
	aheRXCn8UfliE6ZtdS84zVtTWx/Y50zIfS4oQQpYu1IshkXqG/+L0AxiI08cIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763975502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzVduj64WwtY4Ft/U/eQf/i2Ugn3jVPwtZGr0hlDWEo=;
	b=i47QXgovala/oSvVGBwV2wMNZXEW0GL3HuJfUxsVofcjiNbmXR9zXFAnWynrulAwOpF3Kv
	diEKf6hnyjnj6UAg==
From: "tip-bot2 for Alexandre Chartre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Disassemble exception table alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251121095340.464045-23-alexandre.chartre@oracle.com>
References: <20251121095340.464045-23-alexandre.chartre@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176397550161.498.12836048304737119409.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     78df4590c568731cfa12de9ecb888b3b0c141db2
Gitweb:        https://git.kernel.org/tip/78df4590c568731cfa12de9ecb888b3b0c1=
41db2
Author:        Alexandre Chartre <alexandre.chartre@oracle.com>
AuthorDate:    Fri, 21 Nov 2025 10:53:32 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 21 Nov 2025 15:30:14 +01:00

objtool: Disassemble exception table alternatives

When using the --disas option, also disassemble exception tables
(EX_TABLE).

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://patch.msgid.link/20251121095340.464045-23-alexandre.chartre@ora=
cle.com
---
 tools/objtool/disas.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 6083a64..018aba3 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -640,6 +640,26 @@ static int disas_alt_add_insn(struct disas_alt *dalt, in=
t index, char *insn_str,
 }
=20
 /*
+ * Disassemble an exception table alternative.
+ */
+static int disas_alt_extable(struct disas_alt *dalt)
+{
+	struct instruction *alt_insn;
+	char *str;
+
+	alt_insn =3D dalt->alt->insn;
+	str =3D strfmt("resume at 0x%lx <%s+0x%lx>",
+		     alt_insn->offset, alt_insn->sym->name,
+		     alt_insn->offset - alt_insn->sym->offset);
+	if (!str)
+		return -1;
+
+	disas_alt_add_insn(dalt, 0, str, 0);
+
+	return 1;
+}
+
+/*
  * Disassemble an alternative and store instructions in the disas_alt
  * structure. Return the number of instructions in the alternative.
  */
@@ -790,12 +810,16 @@ static void *disas_alt(struct disas_context *dctx,
 		}
=20
 		/*
-		 * Only group alternatives are supported at the moment.
+		 * Only group alternatives and exception tables are
+		 * supported at the moment.
 		 */
 		switch (dalt->alt->type) {
 		case ALT_TYPE_INSTRUCTIONS:
 			count =3D disas_alt_group(dctx, dalt);
 			break;
+		case ALT_TYPE_EX_TABLE:
+			count =3D disas_alt_extable(dalt);
+			break;
 		default:
 			count =3D 0;
 		}


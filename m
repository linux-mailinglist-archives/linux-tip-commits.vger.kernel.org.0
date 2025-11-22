Return-Path: <linux-tip-commits+bounces-7463-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B33C7D35F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C811634D817
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF3285045;
	Sat, 22 Nov 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rYIq+/U7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OAQOLxyc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51B26056C;
	Sat, 22 Nov 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763826520; cv=none; b=MJzDF5DI/kC6UZkzTUCvfEZJseD9fKz3MNF11i9suMrNNifIM1vjAXOOhyJUvUBcUpuVJvdnl0YL2Mpo+ES+1K3TR0h6e6fv5Us9Y/sHz50YQwTgtc41J5TpVZH6t++Z8RYbIqILe0s8LAJFS2rqJ5YLHzeWVYsUbx4V0SJSr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763826520; c=relaxed/simple;
	bh=D8VRL6FT+tsH7zHHQYgA16clG35f1uZtDEf3DMDftK4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N8xp3cqj5pasprS1EkYvEZiydvMKR1PEvzYSvfmsWjepv55qIBdlGHKpoMLQmrVruxReile3Ynd+Rk5GESLRoiXvDskWTRdOfAa2nhFLb1QOiIDKHtXUd4twNqJVnoarbbHZk2/1mBsVNsbq8i+/bFivesbhhoniquqCRYf8Exc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rYIq+/U7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OAQOLxyc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 15:48:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763826516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loMPjcHpBuT69rDfArKEhFAhMe/cLBejCD8cg0hNvmg=;
	b=rYIq+/U7vf/CPsj1IBaRPZQaVEEK25t9ZTBefY9kE0zeLoVxmSfGflHckEb3eezHRUbUCQ
	YwSyVQBtOAquA/mryIR01L1CC3htWc87qEU0jDzdi3ezFbWL3m6Kra+bNFnmZDPGcawq6i
	/fL2vKnmbtB7SpwkrCP+idftlmg3gp+jBnhYPFW3/3l8V3MYIA34ER9HpcLfeu7lObLmnC
	7O/3IgUzjjsVw70XL6mDJwz3qx8R+m/krEfuJMInWgJAV6wZ/N2ZgN4+1GtK49f2j4drnk
	hwvftbR6nolaa9+r4ut8opC9pvWe6e3YEto02twV4uNqbl1U+TLZcVSgjcVvXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763826516;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=loMPjcHpBuT69rDfArKEhFAhMe/cLBejCD8cg0hNvmg=;
	b=OAQOLxyc37BAVJ4yaK0gsVHEVW09797iiNFWNQ6WsFfNs6nF3TYLs2YhQhRUzbjgTXpqwM
	rcm7lY1hxar8RpCg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] fs/resctrl: Modify struct rdt_parse_data to pass
 mode and CLOSID
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <f8ec6ab5cf594d906a3fe75f56793d5fbd63f38f.1762995456.git.babu.moger@amd.com>
References:
 <f8ec6ab5cf594d906a3fe75f56793d5fbd63f38f.1762995456.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382651472.498.9680622511018870683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     af1242eeca50b20076d1bc9a41653005634a8a4f
Gitweb:        https://git.kernel.org/tip/af1242eeca50b20076d1bc9a41653005634=
a8a4f
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Wed, 12 Nov 2025 18:57:34 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 22 Nov 2025 13:10:12 +01:00

fs/resctrl: Modify struct rdt_parse_data to pass mode and CLOSID

parse_cbm() requires resource group mode and CLOSID to validate the capacity
bitmask (CBM). It is passed via struct rdtgroup in struct rdt_parse_data.

The io_alloc feature also uses CBMs to indicate which portions of cache are
allocated for I/O traffic. The CBMs are provided by user space and need to be
validated the same as CBMs provided for general (CPU) cache allocation.
parse_cbm() cannot be used as-is since io_alloc does not have rdtgroup contex=
t.

Pass the resource group mode and CLOSID directly to parse_cbm() via struct
rdt_parse_data, instead of through the rdtgroup struct, to facilitate calling
parse_cbm() to verify the CBM of the io_alloc feature.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://patch.msgid.link/f8ec6ab5cf594d906a3fe75f56793d5fbd63f38f.17629=
95456.git.babu.moger@amd.com
---
 fs/resctrl/ctrlmondata.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 1ac89b1..c43bede 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -24,7 +24,8 @@
 #include "internal.h"
=20
 struct rdt_parse_data {
-	struct rdtgroup		*rdtgrp;
+	u32			closid;
+	enum rdtgrp_mode	mode;
 	char			*buf;
 };
=20
@@ -77,8 +78,8 @@ static int parse_bw(struct rdt_parse_data *data, struct res=
ctrl_schema *s,
 		    struct rdt_ctrl_domain *d)
 {
 	struct resctrl_staged_config *cfg;
-	u32 closid =3D data->rdtgrp->closid;
 	struct rdt_resource *r =3D s->res;
+	u32 closid =3D data->closid;
 	u32 bw_val;
=20
 	cfg =3D &d->staged_config[s->conf_type];
@@ -156,9 +157,10 @@ static bool cbm_validate(char *buf, u32 *data, struct rd=
t_resource *r)
 static int parse_cbm(struct rdt_parse_data *data, struct resctrl_schema *s,
 		     struct rdt_ctrl_domain *d)
 {
-	struct rdtgroup *rdtgrp =3D data->rdtgrp;
+	enum rdtgrp_mode mode =3D data->mode;
 	struct resctrl_staged_config *cfg;
 	struct rdt_resource *r =3D s->res;
+	u32 closid =3D data->closid;
 	u32 cbm_val;
=20
 	cfg =3D &d->staged_config[s->conf_type];
@@ -171,7 +173,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct =
resctrl_schema *s,
 	 * Cannot set up more than one pseudo-locked region in a cache
 	 * hierarchy.
 	 */
-	if (rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
+	if (mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP &&
 	    rdtgroup_pseudo_locked_in_hierarchy(d)) {
 		rdt_last_cmd_puts("Pseudo-locked region in hierarchy\n");
 		return -EINVAL;
@@ -180,8 +182,7 @@ static int parse_cbm(struct rdt_parse_data *data, struct =
resctrl_schema *s,
 	if (!cbm_validate(data->buf, &cbm_val, r))
 		return -EINVAL;
=20
-	if ((rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
-	     rdtgrp->mode =3D=3D RDT_MODE_SHAREABLE) &&
+	if ((mode =3D=3D RDT_MODE_EXCLUSIVE || mode =3D=3D RDT_MODE_SHAREABLE) &&
 	    rdtgroup_cbm_overlaps_pseudo_locked(d, cbm_val)) {
 		rdt_last_cmd_puts("CBM overlaps with pseudo-locked region\n");
 		return -EINVAL;
@@ -191,14 +192,14 @@ static int parse_cbm(struct rdt_parse_data *data, struc=
t resctrl_schema *s,
 	 * The CBM may not overlap with the CBM of another closid if
 	 * either is exclusive.
 	 */
-	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, true)) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, closid, true)) {
 		rdt_last_cmd_puts("Overlaps with exclusive group\n");
 		return -EINVAL;
 	}
=20
-	if (rdtgroup_cbm_overlaps(s, d, cbm_val, rdtgrp->closid, false)) {
-		if (rdtgrp->mode =3D=3D RDT_MODE_EXCLUSIVE ||
-		    rdtgrp->mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
+	if (rdtgroup_cbm_overlaps(s, d, cbm_val, closid, false)) {
+		if (mode =3D=3D RDT_MODE_EXCLUSIVE ||
+		    mode =3D=3D RDT_MODE_PSEUDO_LOCKSETUP) {
 			rdt_last_cmd_puts("Overlaps with other group\n");
 			return -EINVAL;
 		}
@@ -262,7 +263,8 @@ next:
 	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
 		if (d->hdr.id =3D=3D dom_id) {
 			data.buf =3D dom;
-			data.rdtgrp =3D rdtgrp;
+			data.closid =3D rdtgrp->closid;
+			data.mode =3D rdtgrp->mode;
 			if (parse_ctrlval(&data, s, d))
 				return -EINVAL;
 			if (rdtgrp->mode =3D=3D  RDT_MODE_PSEUDO_LOCKSETUP) {


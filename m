Return-Path: <linux-tip-commits+bounces-7789-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD7CF487B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 05 Jan 2026 16:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B185300EDB7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jan 2026 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CCF2C08AD;
	Mon,  5 Jan 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0m7JPorr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ek29KBuq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88889BA3F;
	Mon,  5 Jan 2026 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628459; cv=none; b=lGnuN701fUlkXCssAl0TR2HDqLz2e6CuoX9CBiveWyPuseMgD4xm+cK8c8n3SpBkYzQVB2XI0RsiIyv1a3BYUXojjHm9wURF+KxHieGdEJGXqP8wbJ8Ix/l/+S7AfkTllC4Md4swz7mFnEUvkPXA4Caz6DYguE9kDBH43brAh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628459; c=relaxed/simple;
	bh=l5/ey6qia0g23WePd/rUaP6C1mDLt6XKQx81k8bdgaA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RU/L96qyYuwK5HZWvOj4ZlBI5Pi8zCapX4Vw7mvzxA3+HiwZFc+1shOZGFDD7ccSQ+mNPY4vs7TLS/gR7m5fBof+CXGL4vCHZXEGpasSQkaSoI55KARaS3vO0D8sGSCW53nLUMYx2nfNBP3iquP6TJwF0j4wgp42FJ7FomQZYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0m7JPorr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ek29KBuq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Jan 2026 15:54:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767628453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdEjPDttkHjzGJf1o2VqUTniznimr/NE48K8C06OyHI=;
	b=0m7JPorrxHVk2pOvkOfsjXwyYuLrUL4u4lXCMx3WygQ1UkGn14IZPrXAXIQkkDvBLpyRYl
	uwXRVMAfK1f8hTau6iNdGUpn8hw50HcTW1dsj3RRMA5Ie+AaWw5vyYbnwMg5E5Yf3i2krl
	9YPvZHnFuNtuGqsIol8TK0JNGPHhxGmOVW0NzD8mJCglEDwxvIZM/JLaTF7FDrCmCl2hOw
	xhKm5nnpYvO3zHF7hnyMNchYWHSrd04E4WHh2Ai/WZT1ZGYNuOVVv+5tHu1RJ1rCZY1zqU
	H0yoAZZLF5kl6mL7U/l+9TbpI+OM65So8aAnWPDIu8lRQneUJZ53e0RTNYVM4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767628453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PdEjPDttkHjzGJf1o2VqUTniznimr/NE48K8C06OyHI=;
	b=Ek29KBuqx4VxVuCKVf8AhgdphWQHMV2kfWRLGthnNw/KJ986MwT0kVyXLPZbQJM5VIWyz2
	wDFDahDMj9J3CxDA==
From: "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] security/tomoyo: Enable context analysis
Cc: Marco Elver <elver@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251219154418.3592607-35-elver@google.com>
References: <20251219154418.3592607-35-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176762845187.510.7513930086808663972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     87335b61a23bd10e4aec132bd3a48a009d406973
Gitweb:        https://git.kernel.org/tip/87335b61a23bd10e4aec132bd3a48a009d4=
06973
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 19 Dec 2025 16:40:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 05 Jan 2026 16:43:36 +01:00

security/tomoyo: Enable context analysis

Enable context analysis for security/tomoyo.

This demonstrates a larger conversion to use Clang's context
analysis. The benefit is additional static checking of locking rules,
along with better documentation.

Tomoyo makes use of several synchronization primitives, yet its clear
design made it relatively straightforward to enable context analysis.

One notable finding was:

  security/tomoyo/gc.c:664:20: error: reading variable 'write_buf' requires h=
olding mutex '&tomoyo_io_buffer::io_sem'
    664 |                 is_write =3D head->write_buf !=3D NULL;

For which Tetsuo writes:

  "Good catch. This should be data_race(), for tomoyo_write_control()
   might concurrently update head->write_buf from non-NULL to non-NULL
   with head->io_sem held."

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251219154418.3592607-35-elver@google.com
---
 security/tomoyo/Makefile  |  2 +-
 security/tomoyo/common.c  | 52 ++++++++++++++++++++++++--
 security/tomoyo/common.h  | 77 +++++++++++++++++++-------------------
 security/tomoyo/domain.c  |  1 +-
 security/tomoyo/environ.c |  1 +-
 security/tomoyo/file.c    |  5 ++-
 security/tomoyo/gc.c      | 28 ++++++++++----
 security/tomoyo/mount.c   |  2 +-
 security/tomoyo/network.c |  3 +-
 9 files changed, 122 insertions(+), 49 deletions(-)

diff --git a/security/tomoyo/Makefile b/security/tomoyo/Makefile
index 55c67b9..e3c0f85 100644
--- a/security/tomoyo/Makefile
+++ b/security/tomoyo/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+CONTEXT_ANALYSIS :=3D y
+
 obj-y =3D audit.o common.o condition.o domain.o environ.o file.o gc.o group.=
o load_policy.o memory.o mount.o network.o realpath.o securityfs_if.o tomoyo.=
o util.o
=20
 targets +=3D builtin-policy.h
diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 0f78898..86ce56c 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -268,6 +268,7 @@ static void tomoyo_io_printf(struct tomoyo_io_buffer *hea=
d, const char *fmt,
  */
 static void tomoyo_io_printf(struct tomoyo_io_buffer *head, const char *fmt,
 			     ...)
+	__must_hold(&head->io_sem)
 {
 	va_list args;
 	size_t len;
@@ -416,8 +417,9 @@ static void tomoyo_print_name_union_quoted(struct tomoyo_=
io_buffer *head,
  *
  * Returns nothing.
  */
-static void tomoyo_print_number_union_nospace
-(struct tomoyo_io_buffer *head, const struct tomoyo_number_union *ptr)
+static void
+tomoyo_print_number_union_nospace(struct tomoyo_io_buffer *head, const struc=
t tomoyo_number_union *ptr)
+	__must_hold(&head->io_sem)
 {
 	if (ptr->group) {
 		tomoyo_set_string(head, "@");
@@ -466,6 +468,7 @@ static void tomoyo_print_number_union_nospace
  */
 static void tomoyo_print_number_union(struct tomoyo_io_buffer *head,
 				      const struct tomoyo_number_union *ptr)
+	__must_hold(&head->io_sem)
 {
 	tomoyo_set_space(head);
 	tomoyo_print_number_union_nospace(head, ptr);
@@ -664,6 +667,7 @@ static int tomoyo_set_mode(char *name, const char *value,
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_write_profile(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	char *data =3D head->write_buf;
 	unsigned int i;
@@ -719,6 +723,7 @@ static int tomoyo_write_profile(struct tomoyo_io_buffer *=
head)
  * Caller prints functionality's name.
  */
 static void tomoyo_print_config(struct tomoyo_io_buffer *head, const u8 conf=
ig)
+	__must_hold(&head->io_sem)
 {
 	tomoyo_io_printf(head, "=3D{ mode=3D%s grant_log=3D%s reject_log=3D%s }\n",
 			 tomoyo_mode[config & 3],
@@ -734,6 +739,7 @@ static void tomoyo_print_config(struct tomoyo_io_buffer *=
head, const u8 config)
  * Returns nothing.
  */
 static void tomoyo_read_profile(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	u8 index;
 	struct tomoyo_policy_namespace *ns =3D
@@ -852,6 +858,7 @@ static bool tomoyo_same_manager(const struct tomoyo_acl_h=
ead *a,
  */
 static int tomoyo_update_manager_entry(const char *manager,
 				       const bool is_delete)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_manager e =3D { };
 	struct tomoyo_acl_param param =3D {
@@ -883,6 +890,8 @@ static int tomoyo_update_manager_entry(const char *manage=
r,
  * Caller holds tomoyo_read_lock().
  */
 static int tomoyo_write_manager(struct tomoyo_io_buffer *head)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	char *data =3D head->write_buf;
=20
@@ -901,6 +910,7 @@ static int tomoyo_write_manager(struct tomoyo_io_buffer *=
head)
  * Caller holds tomoyo_read_lock().
  */
 static void tomoyo_read_manager(struct tomoyo_io_buffer *head)
+	__must_hold_shared(&tomoyo_ss)
 {
 	if (head->r.eof)
 		return;
@@ -927,6 +937,7 @@ static void tomoyo_read_manager(struct tomoyo_io_buffer *=
head)
  * Caller holds tomoyo_read_lock().
  */
 static bool tomoyo_manager(void)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_manager *ptr;
 	const char *exe;
@@ -981,6 +992,8 @@ static struct tomoyo_domain_info *tomoyo_find_domain_by_q=
id
  */
 static bool tomoyo_select_domain(struct tomoyo_io_buffer *head,
 				 const char *data)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	unsigned int pid;
 	struct tomoyo_domain_info *domain =3D NULL;
@@ -1051,6 +1064,7 @@ static bool tomoyo_same_task_acl(const struct tomoyo_ac=
l_info *a,
  * Caller holds tomoyo_read_lock().
  */
 static int tomoyo_write_task(struct tomoyo_acl_param *param)
+	__must_hold_shared(&tomoyo_ss)
 {
 	int error =3D -EINVAL;
=20
@@ -1079,6 +1093,7 @@ static int tomoyo_write_task(struct tomoyo_acl_param *p=
aram)
  * Caller holds tomoyo_read_lock().
  */
 static int tomoyo_delete_domain(char *domainname)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_domain_info *domain;
 	struct tomoyo_path_info name;
@@ -1118,6 +1133,7 @@ static int tomoyo_delete_domain(char *domainname)
 static int tomoyo_write_domain2(struct tomoyo_policy_namespace *ns,
 				struct list_head *list, char *data,
 				const bool is_delete)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_acl_param param =3D {
 		.ns =3D ns,
@@ -1162,6 +1178,8 @@ const char * const tomoyo_dif[TOMOYO_MAX_DOMAIN_INFO_FL=
AGS] =3D {
  * Caller holds tomoyo_read_lock().
  */
 static int tomoyo_write_domain(struct tomoyo_io_buffer *head)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	char *data =3D head->write_buf;
 	struct tomoyo_policy_namespace *ns;
@@ -1223,6 +1241,7 @@ static int tomoyo_write_domain(struct tomoyo_io_buffer =
*head)
  */
 static bool tomoyo_print_condition(struct tomoyo_io_buffer *head,
 				   const struct tomoyo_condition *cond)
+	__must_hold(&head->io_sem)
 {
 	switch (head->r.cond_step) {
 	case 0:
@@ -1364,6 +1383,7 @@ static bool tomoyo_print_condition(struct tomoyo_io_buf=
fer *head,
  */
 static void tomoyo_set_group(struct tomoyo_io_buffer *head,
 			     const char *category)
+	__must_hold(&head->io_sem)
 {
 	if (head->type =3D=3D TOMOYO_EXCEPTIONPOLICY) {
 		tomoyo_print_namespace(head);
@@ -1383,6 +1403,7 @@ static void tomoyo_set_group(struct tomoyo_io_buffer *h=
ead,
  */
 static bool tomoyo_print_entry(struct tomoyo_io_buffer *head,
 			       struct tomoyo_acl_info *acl)
+	__must_hold(&head->io_sem)
 {
 	const u8 acl_type =3D acl->type;
 	bool first =3D true;
@@ -1588,6 +1609,8 @@ print_cond_part:
  */
 static bool tomoyo_read_domain2(struct tomoyo_io_buffer *head,
 				struct list_head *list)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	list_for_each_cookie(head->r.acl, list) {
 		struct tomoyo_acl_info *ptr =3D
@@ -1608,6 +1631,8 @@ static bool tomoyo_read_domain2(struct tomoyo_io_buffer=
 *head,
  * Caller holds tomoyo_read_lock().
  */
 static void tomoyo_read_domain(struct tomoyo_io_buffer *head)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	if (head->r.eof)
 		return;
@@ -1686,6 +1711,7 @@ static int tomoyo_write_pid(struct tomoyo_io_buffer *he=
ad)
  * using read()/write() interface rather than sysctl() interface.
  */
 static void tomoyo_read_pid(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	char *buf =3D head->write_buf;
 	bool global_pid =3D false;
@@ -1746,6 +1772,8 @@ static const char *tomoyo_group_name[TOMOYO_MAX_GROUP] =
=3D {
  * Caller holds tomoyo_read_lock().
  */
 static int tomoyo_write_exception(struct tomoyo_io_buffer *head)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	const bool is_delete =3D head->w.is_delete;
 	struct tomoyo_acl_param param =3D {
@@ -1787,6 +1815,8 @@ static int tomoyo_write_exception(struct tomoyo_io_buff=
er *head)
  * Caller holds tomoyo_read_lock().
  */
 static bool tomoyo_read_group(struct tomoyo_io_buffer *head, const int idx)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	struct tomoyo_policy_namespace *ns =3D
 		container_of(head->r.ns, typeof(*ns), namespace_list);
@@ -1846,6 +1876,7 @@ static bool tomoyo_read_group(struct tomoyo_io_buffer *=
head, const int idx)
  * Caller holds tomoyo_read_lock().
  */
 static bool tomoyo_read_policy(struct tomoyo_io_buffer *head, const int idx)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_policy_namespace *ns =3D
 		container_of(head->r.ns, typeof(*ns), namespace_list);
@@ -1906,6 +1937,8 @@ static bool tomoyo_read_policy(struct tomoyo_io_buffer =
*head, const int idx)
  * Caller holds tomoyo_read_lock().
  */
 static void tomoyo_read_exception(struct tomoyo_io_buffer *head)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	struct tomoyo_policy_namespace *ns =3D
 		container_of(head->r.ns, typeof(*ns), namespace_list);
@@ -2097,6 +2130,7 @@ flush:
  * Returns nothing.
  */
 static void tomoyo_add_entry(struct tomoyo_domain_info *domain, char *header)
+	__must_hold_shared(&tomoyo_ss)
 {
 	char *buffer;
 	char *realpath =3D NULL;
@@ -2301,6 +2335,7 @@ static __poll_t tomoyo_poll_query(struct file *file, po=
ll_table *wait)
  * @head: Pointer to "struct tomoyo_io_buffer".
  */
 static void tomoyo_read_query(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	struct list_head *tmp;
 	unsigned int pos =3D 0;
@@ -2362,6 +2397,7 @@ static void tomoyo_read_query(struct tomoyo_io_buffer *=
head)
  * Returns 0 on success, -EINVAL otherwise.
  */
 static int tomoyo_write_answer(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	char *data =3D head->write_buf;
 	struct list_head *tmp;
@@ -2401,6 +2437,7 @@ static int tomoyo_write_answer(struct tomoyo_io_buffer =
*head)
  * Returns version information.
  */
 static void tomoyo_read_version(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	if (!head->r.eof) {
 		tomoyo_io_printf(head, "2.6.0");
@@ -2449,6 +2486,7 @@ void tomoyo_update_stat(const u8 index)
  * Returns nothing.
  */
 static void tomoyo_read_stat(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	u8 i;
 	unsigned int total =3D 0;
@@ -2493,6 +2531,7 @@ static void tomoyo_read_stat(struct tomoyo_io_buffer *h=
ead)
  * Returns 0.
  */
 static int tomoyo_write_stat(struct tomoyo_io_buffer *head)
+	__must_hold(&head->io_sem)
 {
 	char *data =3D head->write_buf;
 	u8 i;
@@ -2717,6 +2756,8 @@ ssize_t tomoyo_read_control(struct tomoyo_io_buffer *he=
ad, char __user *buffer,
  * Caller holds tomoyo_read_lock().
  */
 static int tomoyo_parse_policy(struct tomoyo_io_buffer *head, char *line)
+	__must_hold_shared(&tomoyo_ss)
+	__must_hold(&head->io_sem)
 {
 	/* Delete request? */
 	head->w.is_delete =3D !strncmp(line, "delete ", 7);
@@ -2969,8 +3010,11 @@ void __init tomoyo_load_builtin_policy(void)
 				break;
 			*end =3D '\0';
 			tomoyo_normalize_line(start);
-			head.write_buf =3D start;
-			tomoyo_parse_policy(&head, start);
+			/* head is stack-local and not shared. */
+			context_unsafe(
+				head.write_buf =3D start;
+				tomoyo_parse_policy(&head, start);
+			);
 			start =3D end + 1;
 		}
 	}
diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 3b2a97d..4f1704c 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -827,13 +827,13 @@ struct tomoyo_io_buffer {
 		bool is_delete;
 	} w;
 	/* Buffer for reading.                  */
-	char *read_buf;
+	char *read_buf		__guarded_by(&io_sem);
 	/* Size of read buffer.                 */
-	size_t readbuf_size;
+	size_t readbuf_size	__guarded_by(&io_sem);
 	/* Buffer for writing.                  */
-	char *write_buf;
+	char *write_buf		__guarded_by(&io_sem);
 	/* Size of write buffer.                */
-	size_t writebuf_size;
+	size_t writebuf_size	__guarded_by(&io_sem);
 	/* Type of this interface.              */
 	enum tomoyo_securityfs_interface_index type;
 	/* Users counter protected by tomoyo_io_buffer_list_lock. */
@@ -922,6 +922,35 @@ struct tomoyo_task {
 	struct tomoyo_domain_info *old_domain_info;
 };
=20
+/********** External variable definitions. **********/
+
+extern bool tomoyo_policy_loaded;
+extern int tomoyo_enabled;
+extern const char * const tomoyo_condition_keyword
+[TOMOYO_MAX_CONDITION_KEYWORD];
+extern const char * const tomoyo_dif[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
+extern const char * const tomoyo_mac_keywords[TOMOYO_MAX_MAC_INDEX
+					      + TOMOYO_MAX_MAC_CATEGORY_INDEX];
+extern const char * const tomoyo_mode[TOMOYO_CONFIG_MAX_MODE];
+extern const char * const tomoyo_path_keyword[TOMOYO_MAX_PATH_OPERATION];
+extern const char * const tomoyo_proto_keyword[TOMOYO_SOCK_MAX];
+extern const char * const tomoyo_socket_keyword[TOMOYO_MAX_NETWORK_OPERATION=
];
+extern const u8 tomoyo_index2category[TOMOYO_MAX_MAC_INDEX];
+extern const u8 tomoyo_pn2mac[TOMOYO_MAX_PATH_NUMBER_OPERATION];
+extern const u8 tomoyo_pnnn2mac[TOMOYO_MAX_MKDEV_OPERATION];
+extern const u8 tomoyo_pp2mac[TOMOYO_MAX_PATH2_OPERATION];
+extern struct list_head tomoyo_condition_list;
+extern struct list_head tomoyo_domain_list;
+extern struct list_head tomoyo_name_list[TOMOYO_MAX_HASH];
+extern struct list_head tomoyo_namespace_list;
+extern struct mutex tomoyo_policy_lock;
+extern struct srcu_struct tomoyo_ss;
+extern struct tomoyo_domain_info tomoyo_kernel_domain;
+extern struct tomoyo_policy_namespace tomoyo_kernel_namespace;
+extern unsigned int tomoyo_memory_quota[TOMOYO_MAX_MEMORY_STAT];
+extern unsigned int tomoyo_memory_used[TOMOYO_MAX_MEMORY_STAT];
+extern struct lsm_blob_sizes tomoyo_blob_sizes;
+
 /********** Function prototypes. **********/
=20
 int tomoyo_interface_init(void);
@@ -971,10 +1000,10 @@ const struct tomoyo_path_info *tomoyo_path_matches_gro=
up
 int tomoyo_check_open_permission(struct tomoyo_domain_info *domain,
 				 const struct path *path, const int flag);
 void tomoyo_close_control(struct tomoyo_io_buffer *head);
-int tomoyo_env_perm(struct tomoyo_request_info *r, const char *env);
+int tomoyo_env_perm(struct tomoyo_request_info *r, const char *env) __must_h=
old_shared(&tomoyo_ss);
 int tomoyo_execute_permission(struct tomoyo_request_info *r,
-			      const struct tomoyo_path_info *filename);
-int tomoyo_find_next_domain(struct linux_binprm *bprm);
+			      const struct tomoyo_path_info *filename) __must_hold_shared(&tomoyo=
_ss);
+int tomoyo_find_next_domain(struct linux_binprm *bprm) __must_hold_shared(&t=
omoyo_ss);
 int tomoyo_get_mode(const struct tomoyo_policy_namespace *ns, const u8 profi=
le,
 		    const u8 index);
 int tomoyo_init_request_info(struct tomoyo_request_info *r,
@@ -1002,6 +1031,7 @@ int tomoyo_socket_listen_permission(struct socket *sock=
);
 int tomoyo_socket_sendmsg_permission(struct socket *sock, struct msghdr *msg,
 				     int size);
 int tomoyo_supervisor(struct tomoyo_request_info *r, const char *fmt, ...)
+	__must_hold_shared(&tomoyo_ss)
 	__printf(2, 3);
 int tomoyo_update_domain(struct tomoyo_acl_info *new_entry, const int size,
 			 struct tomoyo_acl_param *param,
@@ -1061,7 +1091,7 @@ void tomoyo_print_ulong(char *buffer, const int buffer_=
len,
 			const unsigned long value, const u8 type);
 void tomoyo_put_name_union(struct tomoyo_name_union *ptr);
 void tomoyo_put_number_union(struct tomoyo_number_union *ptr);
-void tomoyo_read_log(struct tomoyo_io_buffer *head);
+void tomoyo_read_log(struct tomoyo_io_buffer *head) __must_hold(&head->io_se=
m);
 void tomoyo_update_stat(const u8 index);
 void tomoyo_warn_oom(const char *function);
 void tomoyo_write_log(struct tomoyo_request_info *r, const char *fmt, ...)
@@ -1069,35 +1099,6 @@ void tomoyo_write_log(struct tomoyo_request_info *r, c=
onst char *fmt, ...)
 void tomoyo_write_log2(struct tomoyo_request_info *r, int len, const char *f=
mt,
 		       va_list args) __printf(3, 0);
=20
-/********** External variable definitions. **********/
-
-extern bool tomoyo_policy_loaded;
-extern int tomoyo_enabled;
-extern const char * const tomoyo_condition_keyword
-[TOMOYO_MAX_CONDITION_KEYWORD];
-extern const char * const tomoyo_dif[TOMOYO_MAX_DOMAIN_INFO_FLAGS];
-extern const char * const tomoyo_mac_keywords[TOMOYO_MAX_MAC_INDEX
-					      + TOMOYO_MAX_MAC_CATEGORY_INDEX];
-extern const char * const tomoyo_mode[TOMOYO_CONFIG_MAX_MODE];
-extern const char * const tomoyo_path_keyword[TOMOYO_MAX_PATH_OPERATION];
-extern const char * const tomoyo_proto_keyword[TOMOYO_SOCK_MAX];
-extern const char * const tomoyo_socket_keyword[TOMOYO_MAX_NETWORK_OPERATION=
];
-extern const u8 tomoyo_index2category[TOMOYO_MAX_MAC_INDEX];
-extern const u8 tomoyo_pn2mac[TOMOYO_MAX_PATH_NUMBER_OPERATION];
-extern const u8 tomoyo_pnnn2mac[TOMOYO_MAX_MKDEV_OPERATION];
-extern const u8 tomoyo_pp2mac[TOMOYO_MAX_PATH2_OPERATION];
-extern struct list_head tomoyo_condition_list;
-extern struct list_head tomoyo_domain_list;
-extern struct list_head tomoyo_name_list[TOMOYO_MAX_HASH];
-extern struct list_head tomoyo_namespace_list;
-extern struct mutex tomoyo_policy_lock;
-extern struct srcu_struct tomoyo_ss;
-extern struct tomoyo_domain_info tomoyo_kernel_domain;
-extern struct tomoyo_policy_namespace tomoyo_kernel_namespace;
-extern unsigned int tomoyo_memory_quota[TOMOYO_MAX_MEMORY_STAT];
-extern unsigned int tomoyo_memory_used[TOMOYO_MAX_MEMORY_STAT];
-extern struct lsm_blob_sizes tomoyo_blob_sizes;
-
 /********** Inlined functions. **********/
=20
 /**
@@ -1106,6 +1107,7 @@ extern struct lsm_blob_sizes tomoyo_blob_sizes;
  * Returns index number for tomoyo_read_unlock().
  */
 static inline int tomoyo_read_lock(void)
+	__acquires_shared(&tomoyo_ss)
 {
 	return srcu_read_lock(&tomoyo_ss);
 }
@@ -1118,6 +1120,7 @@ static inline int tomoyo_read_lock(void)
  * Returns nothing.
  */
 static inline void tomoyo_read_unlock(int idx)
+	__releases_shared(&tomoyo_ss)
 {
 	srcu_read_unlock(&tomoyo_ss, idx);
 }
diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 90cf0e2..0612eac 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -611,6 +611,7 @@ out:
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_environ(struct tomoyo_execve *ee)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_request_info *r =3D &ee->r;
 	struct linux_binprm *bprm =3D ee->bprm;
diff --git a/security/tomoyo/environ.c b/security/tomoyo/environ.c
index 7f0a471..bcb0591 100644
--- a/security/tomoyo/environ.c
+++ b/security/tomoyo/environ.c
@@ -32,6 +32,7 @@ static bool tomoyo_check_env_acl(struct tomoyo_request_info=
 *r,
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_env_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_supervisor(r, "misc env %s\n",
 				 r->param.environ.name->name);
diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 8f3b90b..e9b67db 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -164,6 +164,7 @@ static bool tomoyo_get_realpath(struct tomoyo_path_info *=
buf, const struct path=20
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_path_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_supervisor(r, "file %s %s\n", tomoyo_path_keyword
 				 [r->param.path.operation],
@@ -178,6 +179,7 @@ static int tomoyo_audit_path_log(struct tomoyo_request_in=
fo *r)
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_path2_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_supervisor(r, "file %s %s %s\n", tomoyo_mac_keywords
 				 [tomoyo_pp2mac[r->param.path2.operation]],
@@ -193,6 +195,7 @@ static int tomoyo_audit_path2_log(struct tomoyo_request_i=
nfo *r)
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_mkdev_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_supervisor(r, "file %s %s 0%o %u %u\n",
 				 tomoyo_mac_keywords
@@ -210,6 +213,7 @@ static int tomoyo_audit_mkdev_log(struct tomoyo_request_i=
nfo *r)
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_path_number_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	const u8 type =3D r->param.path_number.operation;
 	u8 radix;
@@ -572,6 +576,7 @@ static int tomoyo_update_path2_acl(const u8 perm,
  */
 static int tomoyo_path_permission(struct tomoyo_request_info *r, u8 operatio=
n,
 				  const struct tomoyo_path_info *filename)
+	__must_hold_shared(&tomoyo_ss)
 {
 	int error;
=20
diff --git a/security/tomoyo/gc.c b/security/tomoyo/gc.c
index 026e29e..8e20088 100644
--- a/security/tomoyo/gc.c
+++ b/security/tomoyo/gc.c
@@ -23,11 +23,10 @@ static inline void tomoyo_memory_free(void *ptr)
 	tomoyo_memory_used[TOMOYO_MEMORY_POLICY] -=3D ksize(ptr);
 	kfree(ptr);
 }
-
-/* The list for "struct tomoyo_io_buffer". */
-static LIST_HEAD(tomoyo_io_buffer_list);
 /* Lock for protecting tomoyo_io_buffer_list. */
 static DEFINE_SPINLOCK(tomoyo_io_buffer_list_lock);
+/* The list for "struct tomoyo_io_buffer". */
+static __guarded_by(&tomoyo_io_buffer_list_lock) LIST_HEAD(tomoyo_io_buffer_=
list);
=20
 /**
  * tomoyo_struct_used_by_io_buffer - Check whether the list element is used =
by /sys/kernel/security/tomoyo/ users or not.
@@ -385,6 +384,7 @@ static inline void tomoyo_del_number_group(struct list_he=
ad *element)
  */
 static void tomoyo_try_to_gc(const enum tomoyo_policy_id type,
 			     struct list_head *element)
+	__must_hold(&tomoyo_policy_lock)
 {
 	/*
 	 * __list_del_entry() guarantees that the list element became no longer
@@ -484,6 +484,7 @@ reinject:
  */
 static void tomoyo_collect_member(const enum tomoyo_policy_id id,
 				  struct list_head *member_list)
+	__must_hold(&tomoyo_policy_lock)
 {
 	struct tomoyo_acl_head *member;
 	struct tomoyo_acl_head *tmp;
@@ -504,6 +505,7 @@ static void tomoyo_collect_member(const enum tomoyo_polic=
y_id id,
  * Returns nothing.
  */
 static void tomoyo_collect_acl(struct list_head *list)
+	__must_hold(&tomoyo_policy_lock)
 {
 	struct tomoyo_acl_info *acl;
 	struct tomoyo_acl_info *tmp;
@@ -627,8 +629,11 @@ static int tomoyo_gc_thread(void *unused)
 			if (head->users)
 				continue;
 			list_del(&head->list);
-			kfree(head->read_buf);
-			kfree(head->write_buf);
+			/* Safe destruction because no users are left. */
+			context_unsafe(
+				kfree(head->read_buf);
+				kfree(head->write_buf);
+			);
 			kfree(head);
 		}
 		spin_unlock(&tomoyo_io_buffer_list_lock);
@@ -656,11 +661,18 @@ void tomoyo_notify_gc(struct tomoyo_io_buffer *head, co=
nst bool is_register)
 		head->users =3D 1;
 		list_add(&head->list, &tomoyo_io_buffer_list);
 	} else {
-		is_write =3D head->write_buf !=3D NULL;
+		/*
+		 * tomoyo_write_control() can concurrently update write_buf from
+		 * a non-NULL to new non-NULL pointer with io_sem held.
+		 */
+		is_write =3D data_race(head->write_buf !=3D NULL);
 		if (!--head->users) {
 			list_del(&head->list);
-			kfree(head->read_buf);
-			kfree(head->write_buf);
+			/* Safe destruction because no users are left. */
+			context_unsafe(
+				kfree(head->read_buf);
+				kfree(head->write_buf);
+			);
 			kfree(head);
 		}
 	}
diff --git a/security/tomoyo/mount.c b/security/tomoyo/mount.c
index 2755971..322dfd1 100644
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -28,6 +28,7 @@ static const char * const tomoyo_mounts[TOMOYO_MAX_SPECIAL_=
MOUNT] =3D {
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_mount_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_supervisor(r, "file mount %s %s %s 0x%lX\n",
 				 r->param.mount.dev->name,
@@ -78,6 +79,7 @@ static int tomoyo_mount_acl(struct tomoyo_request_info *r,
 			    const char *dev_name,
 			    const struct path *dir, const char *type,
 			    unsigned long flags)
+	__must_hold_shared(&tomoyo_ss)
 {
 	struct tomoyo_obj_info obj =3D { };
 	struct path path;
diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index 8dc6133..cfc2a01 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -363,6 +363,7 @@ int tomoyo_write_unix_network(struct tomoyo_acl_param *pa=
ram)
 static int tomoyo_audit_net_log(struct tomoyo_request_info *r,
 				const char *family, const u8 protocol,
 				const u8 operation, const char *address)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_supervisor(r, "network %s %s %s %s\n", family,
 				 tomoyo_proto_keyword[protocol],
@@ -377,6 +378,7 @@ static int tomoyo_audit_net_log(struct tomoyo_request_inf=
o *r,
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_inet_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	char buf[128];
 	int len;
@@ -402,6 +404,7 @@ static int tomoyo_audit_inet_log(struct tomoyo_request_in=
fo *r)
  * Returns 0 on success, negative value otherwise.
  */
 static int tomoyo_audit_unix_log(struct tomoyo_request_info *r)
+	__must_hold_shared(&tomoyo_ss)
 {
 	return tomoyo_audit_net_log(r, "unix", r->param.unix_network.protocol,
 				    r->param.unix_network.operation,


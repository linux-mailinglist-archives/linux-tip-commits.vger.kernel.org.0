Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0111CF75B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 May 2020 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbgELOhB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 May 2020 10:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgELOhB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 May 2020 10:37:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF9FC061A0F;
        Tue, 12 May 2020 07:37:00 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYW1f-0005mU-3h; Tue, 12 May 2020 16:36:55 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B9EC71C0475;
        Tue, 12 May 2020 16:36:54 +0200 (CEST)
Date:   Tue, 12 May 2020 14:36:54 -0000
From:   "tip-bot2 for Will Deacon" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] gcov: Remove old GCC 3.4 support
Cc:     Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200511204150.27858-16-will@kernel.org>
References: <20200511204150.27858-16-will@kernel.org>
MIME-Version: 1.0
Message-ID: <158929421464.390.14177856938409994788.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     1c1da2d6f6fc27fadd18045247541bab463781fc
Gitweb:        https://git.kernel.org/tip/1c1da2d6f6fc27fadd18045247541bab463781fc
Author:        Will Deacon <will@kernel.org>
AuthorDate:    Mon, 11 May 2020 21:41:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 May 2020 11:04:16 +02:00

gcov: Remove old GCC 3.4 support

The kernel requires at least GCC 4.8 in order to build, and so there is
no need to cater for the pre-4.7 gcov format.

Remove the obsolete code.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Link: https://lkml.kernel.org/r/20200511204150.27858-16-will@kernel.org

---
 kernel/gcov/Kconfig   |  24 +--
 kernel/gcov/Makefile  |   3 +-
 kernel/gcov/gcc_3_4.c | 573 +-----------------------------------------
 3 files changed, 1 insertion(+), 599 deletions(-)
 delete mode 100644 kernel/gcov/gcc_3_4.c

diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index 3941a9c..feaad59 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -51,28 +51,4 @@ config GCOV_PROFILE_ALL
 	larger and run slower. Also be sure to exclude files from profiling
 	which are not linked to the kernel image to prevent linker errors.
 
-choice
-	prompt "Specify GCOV format"
-	depends on GCOV_KERNEL
-	depends on CC_IS_GCC
-	---help---
-	The gcov format is usually determined by the GCC version, and the
-	default is chosen according to your GCC version. However, there are
-	exceptions where format changes are integrated in lower-version GCCs.
-	In such a case, change this option to adjust the format used in the
-	kernel accordingly.
-
-config GCOV_FORMAT_3_4
-	bool "GCC 3.4 format"
-	depends on GCC_VERSION < 40700
-	---help---
-	Select this option to use the format defined by GCC 3.4.
-
-config GCOV_FORMAT_4_7
-	bool "GCC 4.7 format"
-	---help---
-	Select this option to use the format defined by GCC 4.7.
-
-endchoice
-
 endmenu
diff --git a/kernel/gcov/Makefile b/kernel/gcov/Makefile
index d66a74b..16f8ecc 100644
--- a/kernel/gcov/Makefile
+++ b/kernel/gcov/Makefile
@@ -2,6 +2,5 @@
 ccflags-y := -DSRCTREE='"$(srctree)"' -DOBJTREE='"$(objtree)"'
 
 obj-y := base.o fs.o
-obj-$(CONFIG_GCOV_FORMAT_3_4) += gcc_base.o gcc_3_4.o
-obj-$(CONFIG_GCOV_FORMAT_4_7) += gcc_base.o gcc_4_7.o
+obj-$(CONFIG_CC_IS_GCC) += gcc_base.o gcc_4_7.o
 obj-$(CONFIG_CC_IS_CLANG) += clang.o
diff --git a/kernel/gcov/gcc_3_4.c b/kernel/gcov/gcc_3_4.c
deleted file mode 100644
index acb8355..0000000
--- a/kernel/gcov/gcc_3_4.c
+++ /dev/null
@@ -1,573 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  This code provides functions to handle gcc's profiling data format
- *  introduced with gcc 3.4. Future versions of gcc may change the gcov
- *  format (as happened before), so all format-specific information needs
- *  to be kept modular and easily exchangeable.
- *
- *  This file is based on gcc-internal definitions. Functions and data
- *  structures are defined to be compatible with gcc counterparts.
- *  For a better understanding, refer to gcc source: gcc/gcov-io.h.
- *
- *    Copyright IBM Corp. 2009
- *    Author(s): Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
- *
- *    Uses gcc-internal data definitions.
- */
-
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/seq_file.h>
-#include <linux/vmalloc.h>
-#include "gcov.h"
-
-#define GCOV_COUNTERS		5
-
-static struct gcov_info *gcov_info_head;
-
-/**
- * struct gcov_fn_info - profiling meta data per function
- * @ident: object file-unique function identifier
- * @checksum: function checksum
- * @n_ctrs: number of values per counter type belonging to this function
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time.
- */
-struct gcov_fn_info {
-	unsigned int ident;
-	unsigned int checksum;
-	unsigned int n_ctrs[];
-};
-
-/**
- * struct gcov_ctr_info - profiling data per counter type
- * @num: number of counter values for this type
- * @values: array of counter values for this type
- * @merge: merge function for counter values of this type (unused)
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the values array.
- */
-struct gcov_ctr_info {
-	unsigned int	num;
-	gcov_type	*values;
-	void		(*merge)(gcov_type *, unsigned int);
-};
-
-/**
- * struct gcov_info - profiling data per object file
- * @version: gcov version magic indicating the gcc version used for compilation
- * @next: list head for a singly-linked list
- * @stamp: time stamp
- * @filename: name of the associated gcov data file
- * @n_functions: number of instrumented functions
- * @functions: function data
- * @ctr_mask: mask specifying which counter types are active
- * @counts: counter data per counter type
- *
- * This data is generated by gcc during compilation and doesn't change
- * at run-time with the exception of the next pointer.
- */
-struct gcov_info {
-	unsigned int			version;
-	struct gcov_info		*next;
-	unsigned int			stamp;
-	const char			*filename;
-	unsigned int			n_functions;
-	const struct gcov_fn_info	*functions;
-	unsigned int			ctr_mask;
-	struct gcov_ctr_info		counts[];
-};
-
-/**
- * gcov_info_filename - return info filename
- * @info: profiling data set
- */
-const char *gcov_info_filename(struct gcov_info *info)
-{
-	return info->filename;
-}
-
-/**
- * gcov_info_version - return info version
- * @info: profiling data set
- */
-unsigned int gcov_info_version(struct gcov_info *info)
-{
-	return info->version;
-}
-
-/**
- * gcov_info_next - return next profiling data set
- * @info: profiling data set
- *
- * Returns next gcov_info following @info or first gcov_info in the chain if
- * @info is %NULL.
- */
-struct gcov_info *gcov_info_next(struct gcov_info *info)
-{
-	if (!info)
-		return gcov_info_head;
-
-	return info->next;
-}
-
-/**
- * gcov_info_link - link/add profiling data set to the list
- * @info: profiling data set
- */
-void gcov_info_link(struct gcov_info *info)
-{
-	info->next = gcov_info_head;
-	gcov_info_head = info;
-}
-
-/**
- * gcov_info_unlink - unlink/remove profiling data set from the list
- * @prev: previous profiling data set
- * @info: profiling data set
- */
-void gcov_info_unlink(struct gcov_info *prev, struct gcov_info *info)
-{
-	if (prev)
-		prev->next = info->next;
-	else
-		gcov_info_head = info->next;
-}
-
-/**
- * gcov_info_within_module - check if a profiling data set belongs to a module
- * @info: profiling data set
- * @mod: module
- *
- * Returns true if profiling data belongs module, false otherwise.
- */
-bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
-{
-	return within_module((unsigned long)info, mod);
-}
-
-/* Symbolic links to be created for each profiling data file. */
-const struct gcov_link gcov_link[] = {
-	{ OBJ_TREE, "gcno" },	/* Link to .gcno file in $(objtree). */
-	{ 0, NULL},
-};
-
-/*
- * Determine whether a counter is active. Based on gcc magic. Doesn't change
- * at run-time.
- */
-static int counter_active(struct gcov_info *info, unsigned int type)
-{
-	return (1 << type) & info->ctr_mask;
-}
-
-/* Determine number of active counters. Based on gcc magic. */
-static unsigned int num_counter_active(struct gcov_info *info)
-{
-	unsigned int i;
-	unsigned int result = 0;
-
-	for (i = 0; i < GCOV_COUNTERS; i++) {
-		if (counter_active(info, i))
-			result++;
-	}
-	return result;
-}
-
-/**
- * gcov_info_reset - reset profiling data to zero
- * @info: profiling data set
- */
-void gcov_info_reset(struct gcov_info *info)
-{
-	unsigned int active = num_counter_active(info);
-	unsigned int i;
-
-	for (i = 0; i < active; i++) {
-		memset(info->counts[i].values, 0,
-		       info->counts[i].num * sizeof(gcov_type));
-	}
-}
-
-/**
- * gcov_info_is_compatible - check if profiling data can be added
- * @info1: first profiling data set
- * @info2: second profiling data set
- *
- * Returns non-zero if profiling data can be added, zero otherwise.
- */
-int gcov_info_is_compatible(struct gcov_info *info1, struct gcov_info *info2)
-{
-	return (info1->stamp == info2->stamp);
-}
-
-/**
- * gcov_info_add - add up profiling data
- * @dest: profiling data set to which data is added
- * @source: profiling data set which is added
- *
- * Adds profiling counts of @source to @dest.
- */
-void gcov_info_add(struct gcov_info *dest, struct gcov_info *source)
-{
-	unsigned int i;
-	unsigned int j;
-
-	for (i = 0; i < num_counter_active(dest); i++) {
-		for (j = 0; j < dest->counts[i].num; j++) {
-			dest->counts[i].values[j] +=
-				source->counts[i].values[j];
-		}
-	}
-}
-
-/* Get size of function info entry. Based on gcc magic. */
-static size_t get_fn_size(struct gcov_info *info)
-{
-	size_t size;
-
-	size = sizeof(struct gcov_fn_info) + num_counter_active(info) *
-	       sizeof(unsigned int);
-	if (__alignof__(struct gcov_fn_info) > sizeof(unsigned int))
-		size = ALIGN(size, __alignof__(struct gcov_fn_info));
-	return size;
-}
-
-/* Get address of function info entry. Based on gcc magic. */
-static struct gcov_fn_info *get_fn_info(struct gcov_info *info, unsigned int fn)
-{
-	return (struct gcov_fn_info *)
-		((char *) info->functions + fn * get_fn_size(info));
-}
-
-/**
- * gcov_info_dup - duplicate profiling data set
- * @info: profiling data set to duplicate
- *
- * Return newly allocated duplicate on success, %NULL on error.
- */
-struct gcov_info *gcov_info_dup(struct gcov_info *info)
-{
-	struct gcov_info *dup;
-	unsigned int i;
-	unsigned int active;
-
-	/* Duplicate gcov_info. */
-	active = num_counter_active(info);
-	dup = kzalloc(struct_size(dup, counts, active), GFP_KERNEL);
-	if (!dup)
-		return NULL;
-	dup->version		= info->version;
-	dup->stamp		= info->stamp;
-	dup->n_functions	= info->n_functions;
-	dup->ctr_mask		= info->ctr_mask;
-	/* Duplicate filename. */
-	dup->filename		= kstrdup(info->filename, GFP_KERNEL);
-	if (!dup->filename)
-		goto err_free;
-	/* Duplicate table of functions. */
-	dup->functions = kmemdup(info->functions, info->n_functions *
-				 get_fn_size(info), GFP_KERNEL);
-	if (!dup->functions)
-		goto err_free;
-	/* Duplicate counter arrays. */
-	for (i = 0; i < active ; i++) {
-		struct gcov_ctr_info *ctr = &info->counts[i];
-		size_t size = ctr->num * sizeof(gcov_type);
-
-		dup->counts[i].num = ctr->num;
-		dup->counts[i].merge = ctr->merge;
-		dup->counts[i].values = vmalloc(size);
-		if (!dup->counts[i].values)
-			goto err_free;
-		memcpy(dup->counts[i].values, ctr->values, size);
-	}
-	return dup;
-
-err_free:
-	gcov_info_free(dup);
-	return NULL;
-}
-
-/**
- * gcov_info_free - release memory for profiling data set duplicate
- * @info: profiling data set duplicate to free
- */
-void gcov_info_free(struct gcov_info *info)
-{
-	unsigned int active = num_counter_active(info);
-	unsigned int i;
-
-	for (i = 0; i < active ; i++)
-		vfree(info->counts[i].values);
-	kfree(info->functions);
-	kfree(info->filename);
-	kfree(info);
-}
-
-/**
- * struct type_info - iterator helper array
- * @ctr_type: counter type
- * @offset: index of the first value of the current function for this type
- *
- * This array is needed to convert the in-memory data format into the in-file
- * data format:
- *
- * In-memory:
- *   for each counter type
- *     for each function
- *       values
- *
- * In-file:
- *   for each function
- *     for each counter type
- *       values
- *
- * See gcc source gcc/gcov-io.h for more information on data organization.
- */
-struct type_info {
-	int ctr_type;
-	unsigned int offset;
-};
-
-/**
- * struct gcov_iterator - specifies current file position in logical records
- * @info: associated profiling data
- * @record: record type
- * @function: function number
- * @type: counter type
- * @count: index into values array
- * @num_types: number of counter types
- * @type_info: helper array to get values-array offset for current function
- */
-struct gcov_iterator {
-	struct gcov_info *info;
-
-	int record;
-	unsigned int function;
-	unsigned int type;
-	unsigned int count;
-
-	int num_types;
-	struct type_info type_info[];
-};
-
-static struct gcov_fn_info *get_func(struct gcov_iterator *iter)
-{
-	return get_fn_info(iter->info, iter->function);
-}
-
-static struct type_info *get_type(struct gcov_iterator *iter)
-{
-	return &iter->type_info[iter->type];
-}
-
-/**
- * gcov_iter_new - allocate and initialize profiling data iterator
- * @info: profiling data set to be iterated
- *
- * Return file iterator on success, %NULL otherwise.
- */
-struct gcov_iterator *gcov_iter_new(struct gcov_info *info)
-{
-	struct gcov_iterator *iter;
-
-	iter = kzalloc(struct_size(iter, type_info, num_counter_active(info)),
-		       GFP_KERNEL);
-	if (iter)
-		iter->info = info;
-
-	return iter;
-}
-
-/**
- * gcov_iter_free - release memory for iterator
- * @iter: file iterator to free
- */
-void gcov_iter_free(struct gcov_iterator *iter)
-{
-	kfree(iter);
-}
-
-/**
- * gcov_iter_get_info - return profiling data set for given file iterator
- * @iter: file iterator
- */
-struct gcov_info *gcov_iter_get_info(struct gcov_iterator *iter)
-{
-	return iter->info;
-}
-
-/**
- * gcov_iter_start - reset file iterator to starting position
- * @iter: file iterator
- */
-void gcov_iter_start(struct gcov_iterator *iter)
-{
-	int i;
-
-	iter->record = 0;
-	iter->function = 0;
-	iter->type = 0;
-	iter->count = 0;
-	iter->num_types = 0;
-	for (i = 0; i < GCOV_COUNTERS; i++) {
-		if (counter_active(iter->info, i)) {
-			iter->type_info[iter->num_types].ctr_type = i;
-			iter->type_info[iter->num_types++].offset = 0;
-		}
-	}
-}
-
-/* Mapping of logical record number to actual file content. */
-#define RECORD_FILE_MAGIC	0
-#define RECORD_GCOV_VERSION	1
-#define RECORD_TIME_STAMP	2
-#define RECORD_FUNCTION_TAG	3
-#define RECORD_FUNCTON_TAG_LEN	4
-#define RECORD_FUNCTION_IDENT	5
-#define RECORD_FUNCTION_CHECK	6
-#define RECORD_COUNT_TAG	7
-#define RECORD_COUNT_LEN	8
-#define RECORD_COUNT		9
-
-/**
- * gcov_iter_next - advance file iterator to next logical record
- * @iter: file iterator
- *
- * Return zero if new position is valid, non-zero if iterator has reached end.
- */
-int gcov_iter_next(struct gcov_iterator *iter)
-{
-	switch (iter->record) {
-	case RECORD_FILE_MAGIC:
-	case RECORD_GCOV_VERSION:
-	case RECORD_FUNCTION_TAG:
-	case RECORD_FUNCTON_TAG_LEN:
-	case RECORD_FUNCTION_IDENT:
-	case RECORD_COUNT_TAG:
-		/* Advance to next record */
-		iter->record++;
-		break;
-	case RECORD_COUNT:
-		/* Advance to next count */
-		iter->count++;
-		/* fall through */
-	case RECORD_COUNT_LEN:
-		if (iter->count < get_func(iter)->n_ctrs[iter->type]) {
-			iter->record = 9;
-			break;
-		}
-		/* Advance to next counter type */
-		get_type(iter)->offset += iter->count;
-		iter->count = 0;
-		iter->type++;
-		/* fall through */
-	case RECORD_FUNCTION_CHECK:
-		if (iter->type < iter->num_types) {
-			iter->record = 7;
-			break;
-		}
-		/* Advance to next function */
-		iter->type = 0;
-		iter->function++;
-		/* fall through */
-	case RECORD_TIME_STAMP:
-		if (iter->function < iter->info->n_functions)
-			iter->record = 3;
-		else
-			iter->record = -1;
-		break;
-	}
-	/* Check for EOF. */
-	if (iter->record == -1)
-		return -EINVAL;
-	else
-		return 0;
-}
-
-/**
- * seq_write_gcov_u32 - write 32 bit number in gcov format to seq_file
- * @seq: seq_file handle
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file.
- */
-static int seq_write_gcov_u32(struct seq_file *seq, u32 v)
-{
-	return seq_write(seq, &v, sizeof(v));
-}
-
-/**
- * seq_write_gcov_u64 - write 64 bit number in gcov format to seq_file
- * @seq: seq_file handle
- * @v: value to be stored
- *
- * Number format defined by gcc: numbers are recorded in the 32 bit
- * unsigned binary form of the endianness of the machine generating the
- * file. 64 bit numbers are stored as two 32 bit numbers, the low part
- * first.
- */
-static int seq_write_gcov_u64(struct seq_file *seq, u64 v)
-{
-	u32 data[2];
-
-	data[0] = (v & 0xffffffffUL);
-	data[1] = (v >> 32);
-	return seq_write(seq, data, sizeof(data));
-}
-
-/**
- * gcov_iter_write - write data for current pos to seq_file
- * @iter: file iterator
- * @seq: seq_file handle
- *
- * Return zero on success, non-zero otherwise.
- */
-int gcov_iter_write(struct gcov_iterator *iter, struct seq_file *seq)
-{
-	int rc = -EINVAL;
-
-	switch (iter->record) {
-	case RECORD_FILE_MAGIC:
-		rc = seq_write_gcov_u32(seq, GCOV_DATA_MAGIC);
-		break;
-	case RECORD_GCOV_VERSION:
-		rc = seq_write_gcov_u32(seq, iter->info->version);
-		break;
-	case RECORD_TIME_STAMP:
-		rc = seq_write_gcov_u32(seq, iter->info->stamp);
-		break;
-	case RECORD_FUNCTION_TAG:
-		rc = seq_write_gcov_u32(seq, GCOV_TAG_FUNCTION);
-		break;
-	case RECORD_FUNCTON_TAG_LEN:
-		rc = seq_write_gcov_u32(seq, 2);
-		break;
-	case RECORD_FUNCTION_IDENT:
-		rc = seq_write_gcov_u32(seq, get_func(iter)->ident);
-		break;
-	case RECORD_FUNCTION_CHECK:
-		rc = seq_write_gcov_u32(seq, get_func(iter)->checksum);
-		break;
-	case RECORD_COUNT_TAG:
-		rc = seq_write_gcov_u32(seq,
-			GCOV_TAG_FOR_COUNTER(get_type(iter)->ctr_type));
-		break;
-	case RECORD_COUNT_LEN:
-		rc = seq_write_gcov_u32(seq,
-				get_func(iter)->n_ctrs[iter->type] * 2);
-		break;
-	case RECORD_COUNT:
-		rc = seq_write_gcov_u64(seq,
-			iter->info->counts[iter->type].
-				values[iter->count + get_type(iter)->offset]);
-		break;
-	}
-	return rc;
-}

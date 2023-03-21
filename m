Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0ED6C35A7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Mar 2023 16:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjCUP2u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Mar 2023 11:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjCUP2j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Mar 2023 11:28:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B726166DC;
        Tue, 21 Mar 2023 08:28:28 -0700 (PDT)
Date:   Tue, 21 Mar 2023 15:28:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679412506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYxWPP9xT9EgkdZRP+dioQ8Pndpy4nEBNwLa/t3xITI=;
        b=lJdc4Cm+aCpB6Sf1DdhDkuEgBbLQJ5CUXTMLpFyhnByEUvllRq/4UMbulIiW7uzT/KX1Jx
        J0PJzg6W42XB1nAE3B6eLLFDLaQJEWsVAPhMmuubZH7hz8u/dwJCCUyJ436lO9ymxUDsUt
        /WEkjAJdWMLvHOqfcYwFoOhr72bGU26nCTJzHJwYNwWwThtdo8EZm8WIWPm9htjdPWdx4i
        ZtdvTLb33MwvgqNj3HEunGwb1P8GNsjhsYMvVMBXoXUAMyPohAjd3QCrjgYlTcxiV8l/A/
        p2DosmUclWCllHtAjee4C1aaXqGZVvIIOi3dLqKgpaO9C/STMFkgj/49V2G2RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679412506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYxWPP9xT9EgkdZRP+dioQ8Pndpy4nEBNwLa/t3xITI=;
        b=Z3NlWj7urHTINTA7CRCZkMQtyCX1yshByj6/mR7nsI5JhBprysUAUl369Zow0pmWO360CW
        WN0snqxQdZO0wmAw==
From:   "tip-bot2 for Dionna Glaze" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Change snp_guest_issue_request()'s fw_err argument
Cc:     kernel test robot <lkp@intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <202303070609.vX6wp2Af-lkp@intel.com>
References: <202303070609.vX6wp2Af-lkp@intel.com>
MIME-Version: 1.0
Message-ID: <167941250583.5837.11708292888091408190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0144e3b85d7b42e8a4cda991c0e81f131897457a
Gitweb:        https://git.kernel.org/tip/0144e3b85d7b42e8a4cda991c0e81f131897457a
Author:        Dionna Glaze <dionnaglaze@google.com>
AuthorDate:    Tue, 07 Mar 2023 20:24:49 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 21 Mar 2023 15:43:19 +01:00

x86/sev: Change snp_guest_issue_request()'s fw_err argument

The GHCB specification declares that the firmware error value for
a guest request will be stored in the lower 32 bits of EXIT_INFO_2.  The
upper 32 bits are for the VMM's own error code. The fw_err argument to
snp_guest_issue_request() is thus a misnomer, and callers will need
access to all 64 bits.

The type of unsigned long also causes problems, since sw_exit_info2 is
u64 (unsigned long long) vs the argument's unsigned long*. Change this
type for issuing the guest request. Pass the ioctl command struct's error
field directly instead of in a local variable, since an incomplete guest
request may not set the error code, and uninitialized stack memory would
be written back to user space.

The firmware might not even be called, so bookend the call with the no
firmware call error and clear the error.

Since the "fw_err" field is really exitinfo2 split into the upper bits'
vmm error code and lower bits' firmware error code, convert the 64 bit
value to a union.

  [ bp:
   - Massage commit message
   - adjust code
   - Fix a build issue as
   Reported-by: kernel test robot <lkp@intel.com>
   Link: https://lore.kernel.org/oe-kbuild-all/202303070609.vX6wp2Af-lkp@intel.com
   - print exitinfo2 in hex
   Tom:
    - Correct -EIO exit case. ]

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230214164638.1189804-5-dionnaglaze@google.com
Link: https://lore.kernel.org/r/20230307192449.24732-12-bp@alien8.de
---
 Documentation/virt/coco/sev-guest.rst   | 20 ++++---
 arch/x86/include/asm/sev-common.h       |  4 +-
 arch/x86/include/asm/sev.h              | 10 ++-
 arch/x86/kernel/sev.c                   | 15 ++---
 drivers/virt/coco/sev-guest/sev-guest.c | 72 +++++++++++++-----------
 include/uapi/linux/sev-guest.h          | 18 +++++-
 6 files changed, 83 insertions(+), 56 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index aa3e4c6..68b0d23 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -37,11 +37,11 @@ along with a description:
       the return value.  General error numbers (-ENOMEM, -EINVAL)
       are not detailed, but errors with specific meanings are.
 
-The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
-The ioctl accepts struct snp_user_guest_request. The input and output structure is
-specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set. Otherwise, fw_err
-will be set to 0x00000000ffffffff, i.e., the lower 32-bits are -1.
+The guest ioctl should be issued on a file descriptor of the /dev/sev-guest
+device.  The ioctl accepts struct snp_user_guest_request. The input and
+output structure is specified through the req_data and resp_data field
+respectively. If the ioctl fails to execute due to a firmware error, then
+the fw_error code will be set, otherwise fw_error will be set to -1.
 
 The firmware checks that the message sequence counter is one greater than
 the guests message sequence counter. If guest driver fails to increment message
@@ -57,8 +57,14 @@ counter (e.g. counter overflow), then -EIO will be returned.
                 __u64 req_data;
                 __u64 resp_data;
 
-                /* firmware error code on failure (see psp-sev.h) */
-                __u64 fw_err;
+                /* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+                union {
+                        __u64 exitinfo2;
+                        struct {
+                                __u32 fw_error;
+                                __u32 vmm_error;
+                        };
+                };
         };
 
 2.1 SNP_GET_REPORT
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index b63be69..0759af9 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -128,10 +128,6 @@ struct snp_psc_desc {
 	struct psc_entry entries[VMGEXIT_PSC_MAX_ENTRY];
 } __packed;
 
-/* Guest message request error codes */
-#define SNP_GUEST_REQ_INVALID_LEN	BIT_ULL(32)
-#define SNP_GUEST_REQ_ERR_BUSY		BIT_ULL(33)
-
 #define GHCB_MSR_TERM_REQ		0x100
 #define GHCB_MSR_TERM_REASON_SET_POS	12
 #define GHCB_MSR_TERM_REASON_SET_MASK	0xf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index ebc271b..13dc2a9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -9,6 +9,8 @@
 #define __ASM_ENCRYPTED_STATE_H
 
 #include <linux/types.h>
+#include <linux/sev-guest.h>
+
 #include <asm/insn.h>
 #include <asm/sev-common.h>
 #include <asm/bootparam.h>
@@ -185,6 +187,9 @@ static inline int pvalidate(unsigned long vaddr, bool rmp_psize, bool validate)
 
 	return rc;
 }
+
+struct snp_guest_request_ioctl;
+
 void setup_ghcb(void);
 void __init early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
 					 unsigned int npages);
@@ -196,7 +201,7 @@ void snp_set_memory_private(unsigned long vaddr, unsigned int npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err);
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -216,8 +221,7 @@ static inline void snp_set_memory_private(unsigned long vaddr, unsigned int npag
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
 static inline void snp_abort(void) { }
-static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input,
-					  unsigned long *fw_err)
+static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	return -ENOTTY;
 }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 3f664ab..b031244 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,8 @@
 #include <linux/efi.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/psp-sev.h>
+#include <uapi/linux/sev-guest.h>
 
 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2175,7 +2177,7 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned long *fw_err)
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
 	struct es_em_ctxt ctxt;
@@ -2183,8 +2185,7 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned 
 	struct ghcb *ghcb;
 	int ret;
 
-	if (!fw_err)
-		return -EINVAL;
+	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
 
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
@@ -2209,16 +2210,16 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, unsigned 
 	if (ret)
 		goto e_put;
 
-	*fw_err = ghcb->save.sw_exit_info_2;
-	switch (*fw_err) {
+	rio->exitinfo2 = ghcb->save.sw_exit_info_2;
+	switch (rio->exitinfo2) {
 	case 0:
 		break;
 
-	case SNP_GUEST_REQ_ERR_BUSY:
+	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_BUSY):
 		ret = -EAGAIN;
 		break;
 
-	case SNP_GUEST_REQ_INVALID_LEN:
+	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
 		/* Number of expected pages are returned in RBX */
 		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
 			input->data_npages = ghcb_get_rbx(ghcb);
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 0c7b47a..97dbe71 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -332,11 +332,12 @@ static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8
 	return __enc_payload(snp_dev, req, payload, sz);
 }
 
-static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, __u64 *fw_err)
+static int __handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				  struct snp_guest_request_ioctl *rio)
 {
-	unsigned long err = 0xff, override_err = 0;
 	unsigned long req_start = jiffies;
 	unsigned int override_npages = 0;
+	u64 override_err = 0;
 	int rc;
 
 retry_request:
@@ -346,7 +347,7 @@ retry_request:
 	 * sequence number must be incremented or the VMPCK must be deleted to
 	 * prevent reuse of the IV.
 	 */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, rio);
 	switch (rc) {
 	case -ENOSPC:
 		/*
@@ -364,7 +365,7 @@ retry_request:
 		 * request buffer size was too small and give the caller the
 		 * required buffer size.
 		 */
-		override_err	= SNP_GUEST_REQ_INVALID_LEN;
+		override_err = SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN);
 
 		/*
 		 * If this call to the firmware succeeds, the sequence number can
@@ -377,7 +378,7 @@ retry_request:
 		goto retry_request;
 
 	/*
-	 * The host may return SNP_GUEST_REQ_ERR_EBUSY if the request has been
+	 * The host may return SNP_GUEST_VMM_ERR_BUSY if the request has been
 	 * throttled. Retry in the driver to avoid returning and reusing the
 	 * message sequence number on a different message.
 	 */
@@ -398,27 +399,29 @@ retry_request:
 	 */
 	snp_inc_msg_seqno(snp_dev);
 
-	if (fw_err)
-		*fw_err = override_err ?: err;
+	if (override_err) {
+		rio->exitinfo2 = override_err;
+
+		/*
+		 * If an extended guest request was issued and the supplied certificate
+		 * buffer was not large enough, a standard guest request was issued to
+		 * prevent IV reuse. If the standard request was successful, return -EIO
+		 * back to the caller as would have originally been returned.
+		 */
+		if (!rc && override_err == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
+			rc = -EIO;
+	}
 
 	if (override_npages)
 		snp_dev->input.data_npages = override_npages;
 
-	/*
-	 * If an extended guest request was issued and the supplied certificate
-	 * buffer was not large enough, a standard guest request was issued to
-	 * prevent IV reuse. If the standard request was successful, return -EIO
-	 * back to the caller as would have originally been returned.
-	 */
-	if (!rc && override_err == SNP_GUEST_REQ_INVALID_LEN)
-		return -EIO;
-
 	return rc;
 }
 
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code,
+				struct snp_guest_request_ioctl *rio, u8 type,
+				void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz)
 {
 	u64 seqno;
 	int rc;
@@ -432,7 +435,7 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
 
 	/* Encrypt the userspace provided payload in snp_dev->secret_request. */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	rc = enc_payload(snp_dev, seqno, rio->msg_version, type, req_buf, req_sz);
 	if (rc)
 		return rc;
 
@@ -443,12 +446,16 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
 	memcpy(snp_dev->request, &snp_dev->secret_request,
 	       sizeof(snp_dev->secret_request));
 
-	rc = __handle_guest_request(snp_dev, exit_code, fw_err);
+	rc = __handle_guest_request(snp_dev, exit_code, rio);
 	if (rc) {
-		if (rc == -EIO && *fw_err == SNP_GUEST_REQ_INVALID_LEN)
+		if (rc == -EIO &&
+		    rio->exitinfo2 == SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN))
 			return rc;
 
-		dev_alert(snp_dev->dev, "Detected error from ASP request. rc: %d, fw_err: %llu\n", rc, *fw_err);
+		dev_alert(snp_dev->dev,
+			  "Detected error from ASP request. rc: %d, exitinfo2: 0x%llx\n",
+			  rc, rio->exitinfo2);
+
 		snp_disable_vmpck(snp_dev);
 		return rc;
 	}
@@ -488,9 +495,9 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
 	if (!resp)
 		return -ENOMEM;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
 				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
+				  resp_len);
 	if (rc)
 		goto e_free;
 
@@ -528,9 +535,8 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
 	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
 		return -EFAULT;
 
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len);
 	if (rc)
 		return rc;
 
@@ -590,12 +596,12 @@ cmd:
 		return -ENOMEM;
 
 	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg,
 				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+				   sizeof(req.data), resp->data, resp_len);
 
 	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+	if (arg->vmm_error == SNP_GUEST_VMM_ERR_INVALID_LEN) {
 		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
 
 		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
@@ -630,7 +636,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 	if (copy_from_user(&input, argp, sizeof(input)))
 		return -EFAULT;
 
-	input.fw_err = 0xff;
+	input.exitinfo2 = 0xff;
 
 	/* Message version must be non-zero */
 	if (!input.msg_version)
@@ -661,7 +667,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
 
 	mutex_unlock(&snp_cmd_mutex);
 
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+	if (input.exitinfo2 && copy_to_user(argp, &input, sizeof(input)))
 		return -EFAULT;
 
 	return ret;
diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
index 256aaef..2aa3911 100644
--- a/include/uapi/linux/sev-guest.h
+++ b/include/uapi/linux/sev-guest.h
@@ -52,8 +52,14 @@ struct snp_guest_request_ioctl {
 	__u64 req_data;
 	__u64 resp_data;
 
-	/* firmware error code on failure (see psp-sev.h) */
-	__u64 fw_err;
+	/* bits[63:32]: VMM error code, bits[31:0] firmware error code (see psp-sev.h) */
+	union {
+		__u64 exitinfo2;
+		struct {
+			__u32 fw_error;
+			__u32 vmm_error;
+		};
+	};
 };
 
 struct snp_ext_report_req {
@@ -77,4 +83,12 @@ struct snp_ext_report_req {
 /* Get SNP extended report as defined in the GHCB specification version 2. */
 #define SNP_GET_EXT_REPORT _IOWR(SNP_GUEST_REQ_IOC_TYPE, 0x2, struct snp_guest_request_ioctl)
 
+/* Guest message request EXIT_INFO_2 constants */
+#define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
+#define SNP_GUEST_VMM_ERR_SHIFT		32
+#define SNP_GUEST_VMM_ERR(x)		(((u64)x) << SNP_GUEST_VMM_ERR_SHIFT)
+
+#define SNP_GUEST_VMM_ERR_INVALID_LEN	1
+#define SNP_GUEST_VMM_ERR_BUSY		2
+
 #endif /* __UAPI_LINUX_SEV_GUEST_H_ */

Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EC42A606D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Nov 2020 10:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgKDJTT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 Nov 2020 04:19:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27956 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgKDJTS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 Nov 2020 04:19:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A49357v182368;
        Wed, 4 Nov 2020 04:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Kodq/LWw0MNTRbdIREhTCnz9wF8HuVqdZz6l81U4ZYM=;
 b=Pj3AZwktCrJz1CQ/vnjMUYVQs7TSCNjSXoWtV2LRyJFieHT025S3+PMA9Xo0YP+E5Xwn
 GU/MDytcsbUUNv7bAbqe42Jf79Vm5cUPobGGJaFU+7n4J2Vu5PDXXtwxbPRV4UB8yOya
 qF272fgL/tZMAF3aZQKFxyqRZlH+kaV2ZEpppIJpR038ewX+2CapFGQmZeG2eVF8t427
 4auhSE89lBDwcrs6n3u7gQ2/Vo6GsuXzyCk8AfuIOKMPvYXimI3EKL8wDovMG0rIQPtj
 oteqkZV3JNhPPJwRTJxEFG9Fmjq0SCaaQcDs2xKToF0cMu4v+y39pp+Fl0f8y7czt7jj IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34krkq9xa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 04:18:51 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A493bwq184889;
        Wed, 4 Nov 2020 04:18:51 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34krkq9x8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 04:18:50 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A49CQ0I009115;
        Wed, 4 Nov 2020 09:18:48 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 34h01kj4cr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 09:18:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A49Ik4m61735330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 09:18:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58302A4062;
        Wed,  4 Nov 2020 09:18:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95C22A4054;
        Wed,  4 Nov 2020 09:18:45 +0000 (GMT)
Received: from localhost (unknown [9.145.163.252])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  4 Nov 2020 09:18:45 +0000 (GMT)
Date:   Wed, 4 Nov 2020 10:18:43 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [PATCH 1/1] x86/tools: Use tools headers for instruction decoder
 selftests
Message-ID: <your-ad-here.call-01604481523-ext-9352@work.hours>
References: <patch-1.thread-59328d.git-59328d9dc2b9.your-ad-here.call-01604429777-ext-1374@work.hours>
 <202011041702.EIrDb4hS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202011041702.EIrDb4hS-lkp@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_06:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011040068
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Nov 04, 2020 at 05:11:28PM +0800, kernel test robot wrote:
> Hi Vasily,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/x86/core]
> [also build test ERROR on v5.10-rc2 next-20201103]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Vasily-Gorbik/x86-tools-Use-tools-headers-for-instruction-decoder-selftests/20201104-043600
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 238c91115cd05c71447ea071624a4c9fe661f970
> config: x86_64-randconfig-a005-20201104 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1fcd5d5655e29f85e12b402e32974f207cfedf32)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/ab4952becdfae8a76a6f0e0fb4ec7d078e80d5d6
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Vasily-Gorbik/x86-tools-Use-tools-headers-for-instruction-decoder-selftests/20201104-043600
>         git checkout ab4952becdfae8a76a6f0e0fb4ec7d078e80d5d6
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/tools/insn_sanity.c:19:
> >> tools/arch/x86/lib/insn.c:72:7: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    if (peek_nbyte_next(insn_byte_t, insn, i) != prefix[i])
>                        ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:115:6: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>            b = peek_next(insn_byte_t, insn);
>                ^
>    tools/arch/x86/lib/insn.c:34:28: note: expanded from macro 'peek_next'
>    #define peek_next(t, insn)      peek_nbyte_next(t, insn, 0)
>                                    ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:140:7: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    b = peek_next(insn_byte_t, insn);
>                        ^
>    tools/arch/x86/lib/insn.c:34:28: note: expanded from macro 'peek_next'
>    #define peek_next(t, insn)      peek_nbyte_next(t, insn, 0)
>                                    ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:145:7: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    if (unlikely(insn->prefixes.bytes[3])) {
>                        ^
>    tools/arch/x86/lib/insn.c:157:7: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    b = peek_next(insn_byte_t, insn);
>                        ^
>    tools/arch/x86/lib/insn.c:34:28: note: expanded from macro 'peek_next'
>    #define peek_next(t, insn)      peek_nbyte_next(t, insn, 0)
>                                    ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:171:6: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>            b = peek_next(insn_byte_t, insn);
>                ^
>    tools/arch/x86/lib/insn.c:34:28: note: expanded from macro 'peek_next'
>    #define peek_next(t, insn)      peek_nbyte_next(t, insn, 0)
>                                    ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:174:20: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn_byte_t b2 = peek_nbyte_next(insn_byte_t, insn, 1);
>                                     ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:187:9: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                            b2 = peek_nbyte_next(insn_byte_t, insn, 2);
>                                 ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:189:9: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                            b2 = peek_nbyte_next(insn_byte_t, insn, 3);
>                                 ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:197:9: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                            b2 = peek_nbyte_next(insn_byte_t, insn, 2);
>                                 ^
>    tools/arch/x86/lib/insn.c:32:9: note: expanded from macro 'peek_nbyte_next'
>            ({ if (unlikely(!validate_next(t, insn, n))) goto err_out; __peek_nbyte_next(t, insn, n); })
>                   ^
>    tools/arch/x86/lib/insn.c:245:7: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>            op = get_next(insn_byte_t, insn);
>                 ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:265:8: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    op = get_next(insn_byte_t, insn);
>                         ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:297:9: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    mod = get_next(insn_byte_t, insn);
>                          ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:359:22: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                            insn->sib.value = get_next(insn_byte_t, insn);
>                                              ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:410:31: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                            insn->displacement.value = get_next(signed char, insn);
>                                                       ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:415:7: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                                             get_next(short, insn);
> --
>                                           ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:448:26: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->moffset2.value = get_next(int, insn);
>                                           ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:467:27: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate.value = get_next(short, insn);
>                                            ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:472:27: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate.value = get_next(int, insn);
>                                            ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:490:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate1.value = get_next(short, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:494:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate1.value = get_next(int, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:498:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate1.value = get_next(int, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:500:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate2.value = get_next(int, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:518:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate1.value = get_next(short, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:522:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate1.value = get_next(int, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:531:27: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>            insn->immediate2.value = get_next(unsigned short, insn);
>                                     ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:568:27: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate.value = get_next(signed char, insn);
>                                            ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:572:27: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate.value = get_next(short, insn);
>                                            ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:576:27: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate.value = get_next(int, insn);
>                                            ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:580:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate1.value = get_next(int, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:582:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate2.value = get_next(int, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
>    tools/arch/x86/lib/insn.c:602:28: warning: implicit declaration of function 'unlikely' [-Wimplicit-function-declaration]
>                    insn->immediate2.value = get_next(signed char, insn);
>                                             ^
>    tools/arch/x86/lib/insn.c:29:9: note: expanded from macro 'get_next'
>            ({ if (unlikely(!validate_next(t, insn, 0))) goto err_out; __get_next(t, insn); })
>                   ^
> >> arch/x86/tools/insn_sanity.c:128:19: warning: implicit declaration of function 'ARRAY_SIZE' [-Wimplicit-function-declaration]
>            tmp = fgets(buf, ARRAY_SIZE(buf), input_file);
>                             ^
>    37 warnings generated.
>    /usr/bin/ld: /tmp/insn_sanity-8655a9.o: in function `insn_get_prefixes':
> >> insn_sanity.c:(.text+0x1bd): undefined reference to `unlikely'
> >> /usr/bin/ld: insn_sanity.c:(.text+0x203): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x24d): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x30f): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x353): undefined reference to `unlikely'
>    /usr/bin/ld: /tmp/insn_sanity-8655a9.o:insn_sanity.c:(.text+0x38e): more undefined references to `unlikely' follow
>    /usr/bin/ld: /tmp/insn_sanity-8655a9.o: in function `main':
> >> insn_sanity.c:(.text+0x13cf): undefined reference to `ARRAY_SIZE'
>    /usr/bin/ld: /tmp/insn_sanity-8655a9.o: in function `__insn_get_emulate_prefix':
>    insn_sanity.c:(.text+0x1cc1): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x1cef): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x1d1f): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x1d47): undefined reference to `unlikely'
>    /usr/bin/ld: insn_sanity.c:(.text+0x1d6f): undefined reference to `unlikely'
>    clang-12: error: linker command failed with exit code 1 (use -v to see invocation)

Right, this is expected. The patch is based on jpoimboe/objtool/core,
which has extra commits.

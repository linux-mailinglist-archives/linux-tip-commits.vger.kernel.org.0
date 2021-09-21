Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F79412E89
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 08:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhIUGTV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 02:19:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23250 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhIUGTU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 02:19:20 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L42Unl002155;
        Tue, 21 Sep 2021 06:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=k4w8DcLru7C9UG+hcXZOWS7ilSeSPDfcUMNnm2Pw7dE=;
 b=HLcSQ89jqzty4sntfjp+uItofjku7KBXXpZODrAeoTxcKqfMwT3IQMR+6RQ9jB/hbsRr
 M/4d0zAm99K6E5F12cPp5x3zQPOh91S7Z/gZKU85gWfu1Xnew1zgfHuIPOVVEAYr1zQ1
 w51oUlzaVh/hl/KCBaDySoJATV67POKu13UflQeuUH1iGdgYSIqyiiOlUG2Sed4v6BrN
 yof4ppGZHmsE5B+vCINMQwXRevl+N1M/MggWk2eY4Za9dhq89gDxZr4nI0TPFEfR6hQ3
 CwaEfZQGVE2M8X2Da4jOLKaolsBWJRF0w/orpN6teRBao6k2LIfLU8h/MVRXCOgzxERc mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7814gbsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 06:17:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L6AtBv068017;
        Tue, 21 Sep 2021 06:17:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3b565dkfae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 06:17:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJ2VvgT9iNEjoRw94z+IewnfitZyDidqdOHm+vyGBKzp2dllVBg/m6RcDalMA88roJBh+Cx5bcYM31cAW6E0CbgK9vRoH2oyta+4G+8qWoqmazxSm5ZYDhJSLKUusnLDent3cuNkHR7JDPz7V9tuVS0ZbyVVOhcbMO25yY3vukGfzfiEZZ4zAyymPw4mkUgFpDRNmLBY95WPZi1t6tpzUjS1kBgJFVh8+TpbHkivhp3HVnE3497nvB9I/Vh2FoUorxl6LUL+s8bkWFsvC322ivsCAzJ+Mf5prt0pa064A8EqUblZdAyhz/R2Wom3hqIWc7SSeFgJoQWhdP0uitkqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k4w8DcLru7C9UG+hcXZOWS7ilSeSPDfcUMNnm2Pw7dE=;
 b=RxpJq/5qqxyEP9bfykmYWXQJySjXT3AujwyBzrP3nQxegrsialfjfPd5VA5Fk5JSyEGVObMf/ZUeKDZneQN0MCFIIepjGkY2isIFXP5VqvKInPRdrwlpB74ZOo5L5HKhjdW6EgjWKbRDBzwpXMYqTE7IUfwdXab2B8ajbimhlZ+6pdCXoZ0KjROuyNfCorgy2/UGw5LPEtMHgbd1UPOEB69dj/eg8aVtLhw69xnVc7n8WDlAR0j2bIbzg9SERprCxpc5SQj08Q6rVBdbR55axU4Q1wyL0VzIKX1a5Qid+4k3HD8OBEnYo6QQNrl/9W8wmgHjz3r71o0OZr3dMKldsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4w8DcLru7C9UG+hcXZOWS7ilSeSPDfcUMNnm2Pw7dE=;
 b=szYIHgHdetbKfTWrhxWK+gXCtH/6KFCqIFZMY90Qu53gory8Oo8heJdKUM6c3bXZYerEmMtyLdv/mTMPSbDUecctRPW8x1JCt5pesbHM2iJNVcS5UAGyoQA0Vrjkq4bBmPtpUzWGkGAXMZkXtiOCezemQG76r4jFHzu/wRlOwoI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1727.namprd10.prod.outlook.com
 (2603:10b6:301:8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Tue, 21 Sep
 2021 06:17:39 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 06:17:39 +0000
Date:   Tue, 21 Sep 2021 09:17:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Make struct sched_statistics
 independent of fair sched class
Message-ID: <20210921061727.GA24828@kili>
References: <20210905143547.4668-3-laoar.shao@gmail.com>
 <163179357090.25758.13267982301302997472.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163179357090.25758.13267982301302997472.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0147.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:41::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend Transport; Tue, 21 Sep 2021 06:17:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7295e442-3c57-4307-725f-08d97cc7830c
X-MS-TrafficTypeDiagnostic: MWHPR10MB1727:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB172759D80DF2D0A7898D003E8EA19@MWHPR10MB1727.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9ibR8h324nYzaOc+8pCR7vHJqq37OdMcOQnuK9oJRHhZ0K/ZLBeNbGpsu7NwszNM21u4AiJk2U0laFJpFyTCYY63NMQt15vtCcMNOO5OjGsD6I1wA8tapODurJ7Y0ZrtmzqRJE20RZ/BnICn5XGy13jjmwFII7gpjLJR3My9RYhDjHPMZ1G76ZqpIMVBeZNPJ+XoQmLP4Xdq6JFXqzoTDALA32N2Rt+SxP34BBDxb8zRzzIxF/kCNOT3Jw93euuAcAC1H6WOqZ9obmGaS5dLuuAY+kpb1209/zvgkJHw5UgO7k3R7e8BP36qDUOyhihdyTzRFiuApD834/7KRGyRLR6EHGpZPm5AcVTFs8u7AViq2dIpo++zxAuhpdedHAUU21Ki5tuL4d3AbAaBm6Z9uFMGbdhiWB7N55ZibyquqKjJXsnFu5qWZAob6cwOVsdOiiIuz6rvzks5Q+kC+ItEsXaN3Lx22c2mb5k9O0NNVs/zlF8ZCW60OHR40sZiJZCetwfghYVspv37/9qxJlZdiI18QkAVJOHsmrZ2Y9yFewNxjOcyYsoo07fvy+9+VWraajM5tAD2jIRPsa2MFlrTMt5V3fEiaLEc8YbGhZQTdFjubPWueV8lcc2qCwWTRRMTp9XnS/fOBM0sxmgApcyixe0ZdPmjUwhG8gFj7SiQaxuV9/QvQa0QLX939LnlvRDdoh81axsSBOG7AnvLeeuHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(4326008)(2906002)(44832011)(26005)(508600001)(66556008)(66946007)(83380400001)(38100700002)(6666004)(9576002)(4744005)(66476007)(186003)(956004)(316002)(38350700002)(52116002)(33716001)(8676002)(6916009)(55016002)(86362001)(5660300002)(6496006)(33656002)(9686003)(1076003)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FX47fAI37MDuN/rWMWGempkhr1w9zEjq3PfkQ0rdbZWFpZd3s1CEbNKXLsC4?=
 =?us-ascii?Q?4HHyI9wdckkpwJ5B25cs+V5B6nWPF1RaHGdl9KGjxeZ8BX/d5kdZe/B9ePFE?=
 =?us-ascii?Q?+WL4eeW6524sClW3kmk0Y7mk6MbJU+J1Q5SbyP8J9HVr0A1Fyk2/Q2K82j49?=
 =?us-ascii?Q?YI0ByRCP3Lnl081O9UnAGQ/BtxMVVdpiUtp0+lqjR2jI8Z46Ly+rs6GUnGW2?=
 =?us-ascii?Q?acOPULFGFWo6ITMVpJJKh7w+e/3dXUIQMJD6S2/DWQM+5UQjGgX2gEICfQMB?=
 =?us-ascii?Q?8zkWHw82RWYhSEClaDl/R14S5oNWIgmbspngw7fB51JHtiLv+i+ksXKe4sTV?=
 =?us-ascii?Q?8QcxC7fto0zRi+4UmMAL21f31ZwQfSN+A4ouQO39KoLYq9sXTed/lbRmAJ2f?=
 =?us-ascii?Q?i7ZHLFlntHacHljeb4PO/Cgt9oet9BYyBBLBozPCeq6QbT8ELON38oLSqBcf?=
 =?us-ascii?Q?GHC8kz6IrbJvcc6lxLANruvTXxkJQ6vZjwtaQ3kkrdKzUIcqQzKzI+04CLUu?=
 =?us-ascii?Q?x+ITOcNvbZ3X7cSdjShPuvBIL72kWCn14uayFHvhYodyjWphGBELFNzqZ2pg?=
 =?us-ascii?Q?F5kmOCHBz8iKDAdjUyMN3amBaG/ITmtlxTCamHPVFGGxH89oG6UKkZHgmXta?=
 =?us-ascii?Q?CX4iQxzfRYbWWmCziCM6CMVqcOZ8OVMmj3ka71iMf95+OrrMn5C9in1CjzIy?=
 =?us-ascii?Q?gUHyhp+5V0VcJ4REDeVS6U5kaePUXa6J/7RrlLviNAjvRPyP19aO7iaoNysY?=
 =?us-ascii?Q?PPe42nuk4y2z4LtJDody7cCzfXXgq2P6LdhST4kmNeSnHa4Z5HY9MLAaspmB?=
 =?us-ascii?Q?4t5xTP6MvBsLVYESwiVMC2Klv40AxLcZb5xwnOluQxP96gmaCMYjHdVo4snl?=
 =?us-ascii?Q?ZA7+PgnEWJSuZjt2OdXruiyVB0cArLUsB+XBI3gGXpJZwissn8trpr+6oLDW?=
 =?us-ascii?Q?Irmw2NIVPb3wTLy3tf5wAYSj3q1lKlQ6fmCOL9SXiZrCQmbra9oodYYi275+?=
 =?us-ascii?Q?nx/96FQcJiWrudeA/fzIEzwo1kTG3Bj/8+6jnnotyay/E3WTbTuw6jMqrzGA?=
 =?us-ascii?Q?MF2Rxyv7oa/DPiYDFXd2uJE2MHhiu0cvnasX8gNsdHGuoZBfX+mtQ72u7uyx?=
 =?us-ascii?Q?kQZ9+Ltcd4Hs2CkqLBI/+mDF9fT4khfVb5t7bcp/lXCVKRoHjVBPECzDy0ve?=
 =?us-ascii?Q?TDkdtIjhGMlg8fOgqU2MiDlB9H2gDvmHIFCvcnXSImO+Yovf4rmA3+RywWN9?=
 =?us-ascii?Q?jVEjQCIEm6Df2rjXLM8osQOal8iLTn0liAUTLULa3Mr4yZYmuqjec06QyraO?=
 =?us-ascii?Q?0Twt2+sQeVk3iqWS+99zSo8x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7295e442-3c57-4307-725f-08d97cc7830c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:17:39.0821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grJyV6MA3PhcgM+jWR5LboE+VbUk1U8UKHAQ4cFmnpO4TpCm0J27eIO8XBboZqcEwnCI+tyjRComFBNHkcVI55EYRPQzoGFmE+yVKz40bzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1727
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210040
X-Proofpoint-GUID: MuRYNQgNUldcIbWY7gcsvaE8gXnZfEdc
X-Proofpoint-ORIG-GUID: MuRYNQgNUldcIbWY7gcsvaE8gXnZfEdc
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Thu, Sep 16, 2021 at 11:59:30AM -0000, tip-bot2 for Yafang Shao wrote:
> @@ -11424,7 +11441,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  		if (!cfs_rq)
>  			goto err;
>  
> -		se = kzalloc_node(sizeof(struct sched_entity),
> +		se = kzalloc_node(sizeof(struct sched_entity_stats),

This wasn't there in the original patch and it causes a Smatch warning
because "se" is declared as a "sched_entity" but it's allocating a
larger "sched_entity_stats" which contains a sched_entity.

To me, ideally, we would update the type of se.

>  				  GFP_KERNEL, cpu_to_node(i));
>  		if (!se)
>  			goto err_free_rq;

regards,
dan carpenter

